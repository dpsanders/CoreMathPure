# sin.jl — Correctly-rounded sine for Float64
#
# Translated from core-math's src/binary64/sin/sin.c
# Original: Copyright (c) 2022-2025 Paul Zimmermann and Tom Hubrecht (MIT license)

# ───────────────────── double-double helpers ─────────────────────

# Exact product: hi + lo = a * b
@inline function a_mul(a::Float64, b::Float64)
    hi = a * b
    lo = fma(a, b, -hi)
    return hi, lo
end

# Multiply double by double-double: a * (bh + bl), error bounded by ulp(lo)
@inline function s_mul(a::Float64, bh::Float64, bl::Float64)
    hi, lo = a_mul(a, bh)   # exact
    lo = fma(a, bl, lo)
    return hi, lo
end

# (ah + al) * (bh + bl), ignoring al * bl
@inline function d_mul(ah::Float64, al::Float64, bh::Float64, bl::Float64)
    hi, s = a_mul(ah, bh)
    t = fma(al, bh, s)
    lo = fma(ah, bl, t)
    return hi, lo
end

@inline function fast_two_sum(a::Float64, b::Float64)
    hi = a + b
    e = hi - a
    lo = b - e
    return hi, lo
end

# ───────────────────── fast-path polynomial evaluations ─────────────────────

# sin2pi(xh+xl) for 2^-24 <= xh+xl < 2^-11 + 2^-24
# Absolute error < 2^-77.09
function evalPSfast(xh::Float64, xl::Float64, uh::Float64, ul::Float64)
    h = PSfast[5]                     # degree 7
    h = fma(h, uh, PSfast[4])         # degree 5
    h = fma(h, uh, PSfast[3])         # degree 3
    h, l = s_mul(h, uh, ul)
    h, t = fast_two_sum(PSfast[1], h)
    l += PSfast[2] + t
    h, l = d_mul(h, l, xh, xl)       # multiply by xh+xl
    return h, l
end

# cos2pi(xh+xl) for 2^-24 <= xh+xl < 2^-11 + 2^-24
# Relative error < 2^-69.96
function evalPCfast(uh::Float64, ul::Float64)
    h = PCfast[5]                     # degree 6
    h = fma(h, uh, PCfast[4])         # degree 4
    h = fma(h, uh, PCfast[3])         # degree 2
    h, l = s_mul(h, uh, ul)
    h, t = fast_two_sum(PCfast[1], h)
    l += PCfast[2] + t
    return h, l
end

# ───────────────────── accurate-path polynomial evaluations ─────────────────────

# sin2pi(X) for 0 <= X < 2^-11
function evalPS(X::DInt64, X2::DInt64)
    Y = mul_dint_21(X2, PS_TABLE[6])    # degree 11
    Y = add_dint(Y, PS_TABLE[5])        # degree 9
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PS_TABLE[4])        # degree 7
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PS_TABLE[3])        # degree 5
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PS_TABLE[2])        # degree 3
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PS_TABLE[1])        # degree 1
    Y = mul_dint(Y, X)                  # multiply by X
    return Y
end

# cos2pi(X) for 0 <= X < 2^-11
function evalPC(X2::DInt64)
    Y = mul_dint_21(X2, PC_TABLE[6])    # degree 10
    Y = add_dint(Y, PC_TABLE[5])        # degree 8
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PC_TABLE[4])        # degree 6
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PC_TABLE[3])        # degree 4
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PC_TABLE[2])        # degree 2
    Y = mul_dint(Y, X2)
    Y = add_dint(Y, PC_TABLE[1])        # degree 0
    return Y
end

# ───────────────────── argument reduction (accurate) ─────────────────────

# Reduce X to X/(2pi) mod 1, with |error| < 2^-126.67 * |X_out|
function reduce_dint(X::DInt64)
    e = X.ex

    if e <= 1  # |X| < 2
        u = UInt128(X.hi) * UInt128(T_TABLE[2])  # T[1] in C (0-indexed)
        tiny = UInt64(u & typemax(UInt64))
        lo = UInt64(u >> 64)
        u = UInt128(X.hi) * UInt128(T_TABLE[1])  # T[0] in C
        lo += UInt64(u & typemax(UInt64))
        hi = UInt64(u >> 64) + UInt64(lo < UInt64(u & typemax(UInt64)))
        X = DInt64(hi, lo, X.ex, X.sgn)
        old_ex = X.ex
        X = normalize(X)
        e_diff = old_ex - X.ex
        if e_diff != 0
            lo2 = X.lo | (tiny >> (64 - e_diff))
            X = DInt64(X.hi, lo2, X.ex, X.sgn)
        end
        return X
    end

    # 2 <= e <= 1024
    i = e < 127 ? 0 : (e - 127 + 64 - 1) ÷ 64  # ceil((e-127)/64)

    c = zeros(UInt64, 5)
    u = UInt128(X.hi) * UInt128(T_TABLE[i+4])   # T[i+3] in C
    c[1] = UInt64(u & typemax(UInt64))
    c[2] = UInt64(u >> 64)
    u = UInt128(X.hi) * UInt128(T_TABLE[i+3])   # T[i+2] in C
    c[2] += UInt64(u & typemax(UInt64))
    c[3] = UInt64(u >> 64) + UInt64(c[2] < UInt64(u & typemax(UInt64)))
    u = UInt128(X.hi) * UInt128(T_TABLE[i+2])   # T[i+1] in C
    c[3] += UInt64(u & typemax(UInt64))
    c[4] = UInt64(u >> 64) + UInt64(c[3] < UInt64(u & typemax(UInt64)))
    u = UInt128(X.hi) * UInt128(T_TABLE[i+1])   # T[i] in C
    c[4] += UInt64(u & typemax(UInt64))
    c[5] = UInt64(u >> 64) + UInt64(c[4] < UInt64(u & typemax(UInt64)))

    f = e - 64 * i
    if f < 64
        hi = (c[5] << f) | (c[4] >> (64 - f))
        lo = (c[4] << f) | (c[3] >> (64 - f))
        tiny = (c[3] << f) | (c[2] >> (64 - f))
    elseif f == 64
        hi = c[4]
        lo = c[3]
        tiny = c[2]
    else  # 65 <= f <= 127
        g = f - 64
        u = UInt128(X.hi) * UInt128(T_TABLE[i+5])  # T[i+4] in C
        u = u >> 64
        u64 = UInt64(u & typemax(UInt64))
        c[1] += u64
        c[2] += UInt64(c[1] < u64)
        c[3] += UInt64(c[1] < u64 && c[2] == 0)
        c[4] += UInt64(c[1] < u64 && c[2] == 0 && c[3] == 0)
        c[5] += UInt64(c[1] < u64 && c[2] == 0 && c[3] == 0 && c[4] == 0)
        hi = (c[4] << g) | (c[3] >> (64 - g))
        lo = (c[3] << g) | (c[2] >> (64 - g))
        tiny = (c[2] << g) | (c[1] >> (64 - g))
    end

    X = DInt64(hi, lo, 0, X.sgn)
    X = normalize(X)
    if X.ex < 0
        lo2 = X.lo | (tiny >> (64 + X.ex))
        X = DInt64(X.hi, lo2, X.ex, X.sgn)
    end
    return X
end

# Given X with 0 <= X < 1, return (i, X_new) such that X = i/2^11 + X_new
function reduce2(X::DInt64)
    if X.ex <= -11
        return 0, X
    end
    sh = 64 - 11 - X.ex
    i = Int(X.hi >> sh)
    new_hi = X.hi & ((UInt64(1) << sh) - UInt64(1))
    X = normalize(DInt64(new_hi, X.lo, X.ex, X.sgn))
    return i, X
end

# ───────────────────── set_dd: convert two uint64 to double-double ─────────────────────

function set_dd(c1::UInt64, c0::UInt64)
    if c1 != 0
        e = leading_zeros(c1)
        if e != 0
            c1_new = (c1 << e) | (c0 >> (64 - e))
            c0_new = c0 << e
        else
            c1_new = c1
            c0_new = c0
        end
        f = UInt64(0x3fe) - UInt64(e)
        t_u = (f << 52) | ((c1_new << 1) >> 12)
        h = reinterpret(Float64, t_u)
        c0_new = (c1_new << 53) | (c0_new >> 11)
        if c0_new != 0
            g = leading_zeros(c0_new)
            if g != 0
                c0_new = c0_new << g
            end
            t_u = ((f - 53 - UInt64(g)) << 52) | ((c0_new << 1) >> 12)
            l = reinterpret(Float64, t_u)
        else
            l = 0.0
        end
        return h, l
    elseif c0 != 0
        e = leading_zeros(c0)
        f = UInt64(0x3fe) - UInt64(64) - UInt64(e)
        c0_new = c0 << (e + 1)
        t_u = (f << 52) | (c0_new >> 12)
        h = reinterpret(Float64, t_u)
        c0_new = c0_new << 52
        if c0_new != 0
            g = leading_zeros(c0_new)
            c0_new = c0_new << (g + 1)
            t_u = ((f - UInt64(64) - UInt64(g)) << 52) | (c0_new >> 12)
            l = reinterpret(Float64, t_u)
        else
            l = 0.0
        end
        return h, l
    else
        return 0.0, 0.0
    end
end

# ───────────────────── fast argument reduction ─────────────────────

const CH_CONST = 0x1.45f306dc9c883p-3
const CL_CONST = -0x1.6b01ec5417056p-57

function reduce_fast(x::Float64)
    if x <= 0x1.921fb54442d17p+2  # x < 2*pi
        h, l = a_mul(CH_CONST, x)
        l = fma(CL_CONST, x, l)
        err1 = 0x1.d9p-105 * h
    else
        t_u = reinterpret(UInt64, x)
        e = Int((t_u >> 52) & 0x7ff)
        m = (UInt64(1) << 52) | (t_u & 0x000fffffffffffff)
        if e <= 1074
            u = UInt128(m) * UInt128(T_TABLE[2])
            c0 = UInt64(u & typemax(UInt64))
            c1 = UInt64(u >> 64)
            u = UInt128(m) * UInt128(T_TABLE[1])
            c1 += UInt64(u & typemax(UInt64))
            c2 = UInt64(u >> 64) + UInt64(c1 < UInt64(u & typemax(UInt64)))
            e = 1075 - e
        else
            i = (e - 1138 + 63) ÷ 64
            u = UInt128(m) * UInt128(T_TABLE[i+3])
            c0 = UInt64(u & typemax(UInt64))
            c1 = UInt64(u >> 64)
            u = UInt128(m) * UInt128(T_TABLE[i+2])
            c1 += UInt64(u & typemax(UInt64))
            c2 = UInt64(u >> 64) + UInt64(c1 < UInt64(u & typemax(UInt64)))
            u = UInt128(m) * UInt128(T_TABLE[i+1])
            c2 += UInt64(u & typemax(UInt64))
            e = 1139 + (i << 6) - e
        end
        if e == 64
            c0 = c1
            c1 = c2
        else
            c0 = (c1 << (64 - e)) | (c0 >> e)
            c1 = (c2 << (64 - e)) | (c1 >> e)
        end
        h, l = set_dd(c1, c0)
        err1 = 0x1.01p-76
    end

    i = floor(h * 0x1p11)
    h = fma(i, -0x1p-11, h)
    return Int(i), h, l, err1
end

# ───────────────────── sin_fast ─────────────────────

function sin_fast(x::Float64)
    neg = x < 0
    absx = neg ? -x : x

    i, h, l, err1 = reduce_fast(absx)

    neg = xor(neg, (i >> 10) != 0)
    i = i & 0x3ff

    is_sin = true
    is_sin = xor(is_sin, (i >> 9) != 0)
    i = i & 0x1ff

    if (i & 0x100) != 0
        is_sin = !is_sin
        i = 0x1ff - i
        h = 0x1p-11 - h
        l = -l
    end

    # Subtract SC table correction
    h -= SC_TABLE[i+1][1]

    # uh + ul ≈ (h+l)^2
    uh, ul = a_mul(h, h)
    ul = fma(h + h, l, ul)

    sh, sl = evalPSfast(h, l, uh, ul)
    ch, cl = evalPCfast(uh, ul)

    sgn_val = neg ? -1.0 : 1.0

    if is_sin
        sh, sl = s_mul(sgn_val * SC_TABLE[i+1][3], sh, sl)
        ch, cl = s_mul(sgn_val * SC_TABLE[i+1][2], ch, cl)
        h, l2 = fast_two_sum(ch, sh)
        l2 += sl + cl
        err = 0x1.55p-69
    else
        ch, cl = s_mul(sgn_val * SC_TABLE[i+1][3], ch, cl)
        sh, sl = s_mul(sgn_val * SC_TABLE[i+1][2], sh, sl)
        h, l2 = fast_two_sum(ch, -sh)
        l2 += cl - sl
        err = 0x1.81p-69
    end

    return h, l2, err + err1
end

# ───────────────────── sin_accurate ─────────────────────

function sin_accurate(x::Float64)
    absx = x > 0 ? x : -x

    X = dint_fromd(absx)
    X = reduce_dint(X)

    neg = x < 0
    is_sin = true

    i, X = reduce2(X)

    if (i & 0x400) != 0
        neg = !neg
        i = i & 0x3ff
    end

    if (i & 0x200) != 0
        is_sin = false
        i = i & 0x1ff
    end

    if (i & 0x100) != 0
        is_sin = !is_sin
        X = DInt64(X.hi, X.lo, X.ex, UInt64(1))  # negate X
        X = add_dint(MAGIC_DINT, X)                # X -> 2^-11 - X
        i = 0x1ff - i
    end

    X2 = mul_dint(X, X)
    U = evalPC(X2)    # cos2pi(X)
    V = evalPS(X, X2) # sin2pi(X)

    if is_sin
        U = mul_dint(S_TABLE[i+1], U)
        V = mul_dint(C_TABLE[i+1], V)
    else
        U = mul_dint(C_TABLE[i+1], U)
        V = mul_dint(S_TABLE[i+1], V)
        V = DInt64(V.hi, V.lo, V.ex, UInt64(1) - V.sgn)  # negate V
    end

    U = add_dint(U, V)

    # Check if rounding is unambiguous
    err = UInt64(41)
    lo0 = U.lo - err
    hi0 = U.hi - UInt64(lo0 > U.lo)
    lo1 = U.lo + err
    hi1 = U.hi + UInt64(lo1 < U.lo)

    if (hi0 >> 10) != (hi1 >> 10)
        for (xval, rhi, rlo) in SIN_EXCEPTIONS
            if abs(x) == xval
                return x > 0 ? rhi + rlo : -rhi - rlo
            end
        end
    end

    if neg
        U = DInt64(U.hi, U.lo, U.ex, UInt64(1) - U.sgn)
    end

    return dint_tod(U)
end

# ───────────────────── cr_sin: main entry point ─────────────────────

"""
    cr_sin(x::Float64) -> Float64

Correctly-rounded sine function for Float64.
The result is the Float64 nearest to sin(x) (round to nearest, ties to even).
"""
function cr_sin(x::Float64)
    t_u = reinterpret(UInt64, x)
    e = (t_u >> 52) & 0x7ff

    if e == 0x7ff  # NaN, +Inf, -Inf
        if (t_u << 1) != UInt64(0x7ff8) << 49
            return 0.0 / 0.0  # signaling NaN → quiet NaN
        end
        return reinterpret(Float64, ~UInt64(0))  # quiet NaN passthrough
    end

    # For |x| <= 0x1.7137449123ef6p-26, sin(x) rounds to x
    ux = t_u & 0x7fffffffffffffff
    if ux <= 0x3e57137449123ef6
        x == 0 && return x  # preserve -0.0
        return fma(x, -0x1p-54, x)
    end

    h, l, err = sin_fast(x)
    left = h + (l - err)
    right = h + (l + err)
    if left == right
        return left
    end

    return sin_accurate(x)
end
