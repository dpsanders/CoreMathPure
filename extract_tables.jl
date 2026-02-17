# Extract lookup tables from core-math's sin.c and write Julia source
# Run once: julia extract_tables.jl > src/sin_tables.jl

const CFILE = joinpath(dirname(@__DIR__),
    "build/x86_64-linux-gnu/jVD49IgX/srcdir/core-math/src/binary64/sin/sin.c")

src = read(CFILE, String)

println("""# sin_tables.jl — Lookup tables for correctly-rounded sin(Float64)
#
# Auto-extracted from core-math's src/binary64/sin/sin.c
# Original: Copyright (c) 2022-2025 Paul Zimmermann and Tom Hubrecht (MIT license)
""")

# ── T[20]: 1/(2pi) approximation ──
println("# 1/(2pi) approximation: 1/(2pi) ≈ T[1]/2^64 + T[2]/2^128 + ...")
# Use dotall to match across newlines
let block = match(r"static const uint64_t T\[20\] = \{(.*?)\};"s, src).captures[1]
    vals = [m.match for m in eachmatch(r"0x[0-9a-f]+", block)]
    println("const T_TABLE = UInt64[")
    for (i, v) in enumerate(vals)
        println("    $v,  # i=$(i-1)")
    end
    println("]")
end
println()

# ── Helper to extract dint64_t arrays ──
function extract_dint_array(name::String, varname::String, src::String)
    pattern = Regex("static const dint64_t $(name)\\[\\d*\\] = \\{(.*?)\\};", "s")
    m = match(pattern, src)
    m === nothing && error("Could not find $name")
    block = m.captures[1]
    entries = collect(eachmatch(
        r"\{\.hi\s*=\s*(0x[0-9a-f]+),\s*\.lo\s*=\s*(0x[0-9a-f]+),\s*\.ex\s*=\s*(-?\d+),\s*\.sgn\s*=\s*(\d+)\}",
        block))
    println("const $varname = DInt64[")
    for (i, entry) in enumerate(entries)
        hi, lo, ex, sgn = entry.captures
        println("    DInt64($hi, $lo, $ex, $sgn),  # $(i-1)")
    end
    println("]")
    println()
end

# ── S[256] and C[256] ──
extract_dint_array("S", "S_TABLE", src)
extract_dint_array("C", "C_TABLE", src)

# ── PS[] and PC[] (accurate polynomials) ──
extract_dint_array("PS", "PS_TABLE", src)
extract_dint_array("PC", "PC_TABLE", src)

# ── PSfast[] ──
println("# Fast-path sin polynomial coefficients")
let block = match(r"static const\s+double PSfast\[\] = \{(.*?)\};"s, src).captures[1]
    vals = [m.match for m in eachmatch(r"-?0x[0-9a-f]+\.?[0-9a-f]*p[+-]?\d+", block)]
    println("const PSfast = (")
    for v in vals
        println("    $v,")
    end
    println(")")
end
println()

# ── PCfast[] ──
println("# Fast-path cos polynomial coefficients")
let block = match(r"static const\s+double PCfast\[\] = \{(.*?)\};"s, src).captures[1]
    vals = [m.match for m in eachmatch(r"-?0x[0-9a-f]+\.?[0-9a-f]*p[+-]?\d+", block)]
    println("const PCfast = (")
    for v in vals
        println("    $v,")
    end
    println(")")
end
println()

# ── SC[256][3] ──
println("# Combined sin/cos table with correction: (xi_correction, sin, cos)")
let block = match(r"static const double SC\[256\]\[3\] = \{(.*?)\};"s, src).captures[1]
    println("const SC_TABLE = NTuple{3,Float64}[")
    for entry in eachmatch(r"\{([^}]+)\},?\s*/\*\s*(\d+)\s*\*/", block)
        vals_str = entry.captures[1]
        idx = entry.captures[2]
        # Parse hex floats
        vals = [m.match for m in eachmatch(r"-?0x[0-9a-f]+\.?[0-9a-f]*p[+-]?\d+", vals_str)]
        if length(vals) == 3
            println("    ($(vals[1]), $(vals[2]), $(vals[3])),  # $idx")
        elseif length(vals) == 2
            # Entry 0: {0x0p+0, 0x0p+0, 0x1p+0} — first two are zero
            println("    (0.0, 0.0, $(vals[1])),  # $idx")
        elseif length(vals) == 1
            println("    (0.0, 0.0, $(vals[1])),  # $idx")
        end
    end
    println("]")
end
println()

# ── Exceptions ──
println("""# Hard-to-round exceptions for sin_accurate
const SIN_EXCEPTIONS = (
    (0x1.e0000000001c2p-20, 0x1.dfffffffff02ep-20, 0x1.dcba692492527p-146),
    (0x1.6ac5b262ca1ffp+849, 1.0, -0x1.2b089ea1e692bp-123),
)""")
