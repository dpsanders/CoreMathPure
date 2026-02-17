# gen_tables.jl — Extract lookup tables from core-math sin.c and write Julia source
#
# Usage: julia gen_tables.jl path/to/sin.c > src/sin_tables.jl

const cfile = ARGS[1]
const src = read(cfile, String)

println("# sin_tables.jl — Auto-generated from core-math sin.c")
println("# Do not edit by hand. Regenerate with: julia gen_tables.jl path/to/sin.c")
println()

# ── T[20]: 1/(2pi) approximation ──
println("const T_TABLE = UInt64[")
m = match(r"static const uint64_t T\[20\] = \{([^}]+)\}", src)
for hex in eachmatch(r"0x[0-9a-f]+", m.captures[1])
    println("    ", hex.match, ",")
end
println("]")
println()

# ── Helper: extract a dint64_t array ──
function extract_dint_table(name, varname)
    # Match: static const dint64_t NAME[...] = { ... };
    pat = Regex("static const dint64_t $(name)\\[\\d+\\] = \\{(.+?)\\};", "s")
    m = match(pat, src)
    m === nothing && error("Could not find table $name")
    body = m.captures[1]
    println("const $(varname) = DInt64[")
    for e in eachmatch(r"\{\.hi\s*=\s*(0x[0-9a-f]+),\s*\.lo\s*=\s*(0x[0-9a-f]+),\s*\.ex\s*=\s*(-?\d+),\s*\.sgn\s*=\s*(\d+)\}", body)
        hi, lo, ex, sgn = e.captures
        println("    DInt64($hi, $lo, $ex, $sgn),")
    end
    println("]")
    println()
end

extract_dint_table("S", "S_TABLE")
extract_dint_table("C", "C_TABLE")

# ── PS (accurate sin polynomial) ──
println("const PS_TABLE = DInt64[")
m = match(r"static const dint64_t PS\[\] = \{([^}]+(?:\{[^}]*\}[^}]*)+)\};", src)
if m === nothing
    # fallback: grab between "dint64_t PS[]" and next "static const"
    i1 = something(findfirst("dint64_t PS[]", src)).stop
    i2 = findnext("static const", src, i1 + 1)
    body = src[i1:first(i2)-1]
else
    body = m.captures[1]
end
for e in eachmatch(r"\{\.hi\s*=\s*(0x[0-9a-f]+),\s*\.lo\s*=\s*(0x[0-9a-f]+),\s*\.ex\s*=\s*(-?\d+),\s*\.sgn\s*=\s*(\d+)\}", body)
    hi, lo, ex, sgn = e.captures
    println("    DInt64($hi, $lo, $ex, $sgn),")
end
println("]")
println()

# ── PC (accurate cos polynomial) ──
println("const PC_TABLE = DInt64[")
i1 = something(findfirst("dint64_t PC[]", src)).stop
i2 = findnext("static const", src, i1 + 1)
i2 === nothing && (i2 = findnext("/* Table generated", src, i1 + 1))
body = src[i1:first(i2)-1]
for e in eachmatch(r"\{\.hi\s*=\s*(0x[0-9a-f]+),\s*\.lo\s*=\s*(0x[0-9a-f]+),\s*\.ex\s*=\s*(-?\d+),\s*\.sgn\s*=\s*(\d+)\}", body)
    hi, lo, ex, sgn = e.captures
    println("    DInt64($hi, $lo, $ex, $sgn),")
end
println("]")
println()

# ── PSfast (fast sin polynomial) ──
println("const PSfast = (")
m = match(r"static const\s+double PSfast\[\] = \{([^}]+)\}", src)
vals = [m2.match for m2 in eachmatch(r"-?0x[0-9a-f.]+p[+-]?\d+", m.captures[1])]
for v in vals
    println("    $v,")
end
println(")")
println()

# ── PCfast (fast cos polynomial) ──
println("const PCfast = (")
m = match(r"static const\s+double PCfast\[\] = \{([^}]+)\}", src)
vals = [m2.match for m2 in eachmatch(r"-?0x[0-9a-f.]+p[+-]?\d+", m.captures[1])]
# First entry is 0x1p+0 which might show as just a number; handle "1" case
body = m.captures[1]
# The first value might be just "0x1p+0" but let's check for plain numbers too
all_vals = Float64[]
for v in eachmatch(r"-?0x[0-9a-f.]+p[+-]?\d+", body)
    println("    $(v.match),")
end
println(")")
println()

# ── SC[256][3] table ──
println("const SC_TABLE = NTuple{3,Float64}[")
# Find the SC table by locating the 256 row comments /* 0 */ through /* 255 */
sc_start = findfirst("static const double SC[256][3]", src)
sc_start === nothing && error("SC table not found")
sc_body_start = findnext('{', src, last(sc_start))
# Find the end: look for "};" after the last entry "/* 255 */"
sc_end_marker = findnext("/* 255 */", src, sc_body_start)
sc_end = findnext("};", src, last(sc_end_marker))
body = src[sc_body_start:first(sc_end)+1]

global sc_count = 0
for row in eachmatch(r"\{([^}]+)\}", body)
    inner = row.captures[1]
    local vals = String[]
    # Match hex floats: -0x1.abcp-12, 0x1p+0, 0x0p+0, etc.
    for v in eachmatch(r"-?0x[0-9a-f.]+p[+-]?\d+", inner)
        push!(vals, v.match)
    end
    if length(vals) == 3
        local jvals = [v == "0x0p+0" ? "0.0" : v for v in vals]
        println("    ($(jvals[1]), $(jvals[2]), $(jvals[3])),")
        global sc_count += 1
    end
end
@assert sc_count == 256 "Expected 256 SC entries, got $sc_count"
println("]")
println()

# ── Exceptions table ──
println("const SIN_EXCEPTIONS = (")
println("    (0x1.e0000000001c2p-20, 0x1.dfffffffff02ep-20, 0x1.dcba692492527p-146),")
println("    (0x1.6ac5b262ca1ffp+849, 1.0, -0x1.2b089ea1e692bp-123),")
println(")")
