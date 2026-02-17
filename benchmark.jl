using CoreMathPure
using BenchmarkTools

println("=" ^ 70)
println("CoreMathPure cr_sin vs Base.sin — Benchmark Report")
println("=" ^ 70)
println()

# Warmup
cr_sin(1.0); sin(1.0)

# --- Single-value benchmarks ---
println("── Single-value benchmarks ──")
println()

test_vals = [
    ("Small (1e-10)",   1e-10),
    ("Typical (0.5)",   0.5),
    ("Typical (1.0)",   1.0),
    ("Near pi (3.14)",  3.14),
    ("Medium (100.0)",  100.0),
    ("Large (1e15)",    1e15),
    ("Very large (1e100)", 1e100),
]

for (label, x) in test_vals
    b_cr = @benchmark cr_sin($x)
    b_base = @benchmark sin($x)
    t_cr = median(b_cr).time
    t_base = median(b_base).time
    ratio = t_cr / t_base
    println("  $label:")
    println("    cr_sin:   $(round(t_cr, digits=1)) ns")
    println("    Base.sin: $(round(t_base, digits=1)) ns")
    println("    ratio:    $(round(ratio, digits=2))x")
    println()
end

# --- Throughput benchmark over random data ---
println("── Throughput: 10,000 random Float64 values ──")
println()

xs_small = [10.0 * randn() for _ in 1:10_000]
xs_wide = [reinterpret(Float64, (rand(UInt64) & 0x7fefffffffffffff)) * (rand(Bool) ? 1.0 : -1.0) for _ in 1:10_000]

for (label, xs) in [("Normal range (|x| ~ 10)", xs_small), ("Full Float64 range", xs_wide)]
    b_cr = @benchmark (for x in $xs; cr_sin(x); end)
    b_base = @benchmark (for x in $xs; sin(x); end)
    t_cr = median(b_cr).time / 10_000
    t_base = median(b_base).time / 10_000
    ratio = t_cr / t_base
    println("  $label:")
    println("    cr_sin:   $(round(t_cr, digits=1)) ns/call")
    println("    Base.sin: $(round(t_base, digits=1)) ns/call")
    println("    ratio:    $(round(ratio, digits=2))x")
    println()
end

# --- Fast path hit rate ---
println("── Fast path hit rate ──")
println()

fast_count = 0
N = 100_000
for _ in 1:N
    x = 10.0 * randn()
    h, l, err = CoreMathPure.sin_fast(x)
    left = h + (l - err)
    right = h + (l + err)
    if left == right
        global fast_count += 1
    end
end
println("  Fast path resolved: $fast_count / $N ($(round(100*fast_count/N, digits=3))%)")
println()

# --- Correctness verification ---
println("── Correctness ──")
println()
failures = 0
for _ in 1:100_000
    u = rand(UInt64) & 0x7fefffffffffffff
    x = reinterpret(Float64, u)
    rand(Bool) && (x = -x)
    got = cr_sin(x)
    exact = Float64(sin(BigFloat(x, precision=256)))
    if got != exact
        global failures += 1
    end
end
println("  100,000 random values: $failures failures (correctly rounded: $(failures == 0 ? "YES" : "NO"))")
println()
println("=" ^ 70)
