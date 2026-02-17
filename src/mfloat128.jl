# mfloat128.jl — 128-bit floating-point type for correctly-rounded math
#
# Translated from core-math's dint.h and pow.[ch]
# Original: Copyright (c) 2022-2025 Paul Zimmermann and Tom Hubrecht (MIT license)

"""
    MFloat128

Manual 128-bit floating-point number (non-IEEE). Uses a 128-bit mantissa
stored as two UInt64 words (hi, lo), a signed exponent, and a sign bit:

    value = (-1)^sgn * (hi/2^64 + lo/2^128) * 2^ex

where hi has its most significant bit set (normalized form).

Called "MFloat128" because it is a Manual (software-implemented) 128-bit float,
as opposed to IEEE 754 binary128 (Float128). The "M" distinguishes it from
hardware or standards-based 128-bit types. Corresponds to `dint64_t` in the
original core-math C code.
"""
struct MFloat128
    hi::UInt64
    lo::UInt64
    ex::Int64
    sgn::UInt64
end

const ZERO_DINT = MFloat128(0x0, 0x0, -1076, 0x0)
const MAGIC_DINT = MFloat128(0x8000000000000000, 0x0, -10, 0x0)

# Get the 128-bit mantissa as UInt128
@inline mantissa128(d::MFloat128) = (UInt128(d.hi) << 64) | UInt128(d.lo)

# Create MFloat128 from 128-bit mantissa r, preserving ex and sgn
@inline function from_mantissa(r::UInt128, ex::Int64, sgn::UInt64)
    MFloat128(UInt64(r >> 64), UInt64(r & typemax(UInt64)), ex, sgn)
end

Base.iszero(a::MFloat128) = a.hi == 0

@inline cmp_i64(a::Int64, b::Int64) = (a > b) - (a < b)
@inline cmp_u128(a::UInt128, b::UInt128) = (a > b) - (a < b)

# Compare absolute values: -1 if |a| < |b|, 0 if equal, +1 if |a| > |b|
function cmp_abs(a::MFloat128, b::MFloat128)
    iszero(a) && return iszero(b) ? 0 : -1
    iszero(b) && return 1
    c1 = cmp_i64(a.ex, b.ex)
    return c1 != 0 ? c1 : cmp_u128(mantissa128(a), mantissa128(b))
end

# Extract mantissa and exponent from a double
@inline function fast_extract(x::Float64)
    u = reinterpret(UInt64, x)
    e = Int64((u >> 52) & 0x7ff)
    m = (u & (typemax(UInt64) >> 12)) + (e != 0 ? (UInt64(1) << 52) : UInt64(0))
    e = e - Int64(0x3fe)
    return e, m
end

# Convert a non-zero Float64 to MFloat128
function MFloat128(b::Float64)
    ex, hi = fast_extract(b)
    t = leading_zeros(hi)
    sgn = UInt64(b < 0.0)
    hi = hi << t
    ex = ex - (t > 11 ? t - 12 : 0)
    MFloat128(hi, UInt64(0), ex, sgn)
end

# Normalize: ensure hi has its MSB set (if non-zero)
function normalize(X::MFloat128)
    if X.hi != 0
        cnt = leading_zeros(X.hi)
        if cnt != 0
            hi = (X.hi << cnt) | (X.lo >> (64 - cnt))
            lo = X.lo << cnt
        else
            hi = X.hi
            lo = X.lo
        end
        return MFloat128(hi, lo, X.ex - cnt, X.sgn)
    elseif X.lo != 0
        cnt = leading_zeros(X.lo)
        hi = X.lo << cnt
        return MFloat128(hi, UInt64(0), X.ex - 64 - cnt, X.sgn)
    else
        return X
    end
end

# Unary negation
Base.:(-)(a::MFloat128) = MFloat128(a.hi, a.lo, a.ex, UInt64(1) - a.sgn)

# Addition with error bounded by 2 ulps (ulp_128)
function Base.:(+)(a::MFloat128, b::MFloat128)
    if (a.hi | a.lo) == 0
        return b
    end

    c = cmp_abs(a, b)
    if c == 0
        if xor(a.sgn, b.sgn) != 0
            return ZERO_DINT
        end
        return MFloat128(a.hi, a.lo, a.ex + 1, a.sgn)
    elseif c < 0
        a, b = b, a
    end

    A = mantissa128(a)
    B = mantissa128(b)
    k = a.ex - b.ex

    if k > 0
        B = k < 128 ? B >> k : UInt128(0)
    end

    sgn = a.sgn
    rex = a.ex

    if xor(a.sgn, b.sgn) != 0
        C = A - B
        ch = UInt64(C >> 64)
        cl = UInt64(C & typemax(UInt64))
        ex = ch != 0 ? leading_zeros(ch) : 64 + leading_zeros(cl)

        if ex > 0
            if k == 1  # Sterbenz case
                C = (A << ex) - (mantissa128(b) << (ex - 1))
            else
                C = (A << ex) - (B << ex)
            end
            rex -= ex
            ex = leading_zeros(UInt64(C >> 64))
        end
        C = C << ex
        rex -= ex
    else
        C = A + B
        if C < A  # overflow
            C = (UInt128(1) << 127) | (C >> 1)
            rex += 1
        end
    end

    return from_mantissa(C, rex, sgn)
end

# Multiplication with error bounded by 6 ulps
function Base.:(*)(a::MFloat128, b::MFloat128)
    bh = UInt128(b.hi)
    bl = UInt128(b.lo)

    m1 = UInt128(a.hi) * bl
    m2 = UInt128(a.lo) * bh
    r = UInt128(a.hi) * bh
    r += (m1 >> 64) + (m2 >> 64)

    hi = UInt64(r >> 64)
    ex_bit = hi >> 63
    r = r << (1 - ex_bit)

    rex = a.ex + b.ex + Int64(ex_bit) - 1
    rsgn = xor(a.sgn, b.sgn)

    return from_mantissa(r, rex, rsgn)
end

# Multiply two MFloat128 numbers, assuming b.lo == 0 (error bounded by 2 ulps)
function mul_hi(a::MFloat128, b::MFloat128)
    bh = UInt128(b.hi)
    hi_prod = UInt128(a.hi) * bh
    lo_prod = UInt128(a.lo) * bh

    r = hi_prod + (lo_prod >> 64)

    hi = UInt64(r >> 64)
    ex_bit = hi >> 63
    r = r << (1 - ex_bit)

    rex = a.ex + b.ex + Int64(ex_bit) - 1
    rsgn = xor(a.sgn, b.sgn)

    return from_mantissa(r, rex, rsgn)
end

# Subnormalize for round-to-nearest (ties to even)
function subnormalize(a::MFloat128)
    a.ex > -1023 && return a

    ex = -(1011 + a.ex)  # 12 <= ex <= 63

    hi = a.hi >> ex
    md = (a.hi >> (ex - 1)) & UInt64(0x1)
    lo_flag = UInt64(((a.hi & (typemax(UInt64) >> ex)) != 0) | (a.lo != 0))

    hi += lo_flag != 0 ? md : (hi & md)

    new_hi = hi << ex

    if new_hi == 0
        return MFloat128(UInt64(1) << 63, UInt64(0), a.ex + 1, a.sgn)
    end
    return MFloat128(new_hi, UInt64(0), a.ex, a.sgn)
end

# Convert MFloat128 to Float64 (round to nearest)
function Base.Float64(a::MFloat128)
    a = subnormalize(a)

    r_u = (a.hi >> 11) | (UInt64(0x3ff) << 52)

    rd = 0.0
    if ((a.hi >> 10) & 0x1) != 0
        rd += 0x1p-53
    end
    if (a.hi & 0x3ff) != 0 || a.lo != 0
        rd += 0x1p-54
    end
    if a.sgn != 0
        rd = -rd
    end

    r_u = r_u | (a.sgn << 63)
    r_f = reinterpret(Float64, r_u) + rd

    if a.ex > -1022
        if a.ex > 1024
            if a.ex == 1025
                r_f = r_f * 0x1p+1
                e_f = 0x1p+1023
            else
                r_f = 0x1.fffffffffffffp+1023
                e_f = 0x1.fffffffffffffp+1023
            end
        else
            e_u = UInt64((a.ex + 1022) & 0x7ff) << 52
            e_f = reinterpret(Float64, e_u)
        end
    else
        if a.ex < -1073
            if a.ex == -1074
                r_f = r_f * 0x1p-1
                e_f = 0x1p-1074
            else
                r_f = 0x1p-1074
                e_f = 0x1p-1074
            end
        else
            e_u = UInt64(1) << (a.ex + 1073)
            e_f = reinterpret(Float64, e_u)
        end
    end

    return r_f * e_f
end
