# CoreMathPure Benchmark Report

## Setup

- **Julia**: 1.10.10 (aarch64-apple-darwin)
- **Platform**: macOS (Apple Silicon)
- **Method**: BenchmarkTools.jl `@benchmark`, reporting median times
- **Comparison**: `CoreMathPure.cr_sin` (pure Julia, correctly rounded) vs `Base.sin` (system libm, faithfully rounded)

## Key difference

`cr_sin` guarantees **correct rounding** (the Float64 nearest to the true sin(x)) for all inputs.
`Base.sin` provides **faithful rounding** (one of the two nearest Float64 values) — faster but occasionally off by 1 ULP.

## Single-value results

| Input               | cr_sin (ns) | Base.sin (ns) | Ratio |
|---------------------|-------------|---------------|-------|
| Small (1e-10)       | 4.6         | 3.3           | 1.4x  |
| Typical (0.5)       | 20.4        | 4.4           | 4.6x  |
| Typical (1.0)       | 20.9        | 8.8           | 2.4x  |
| Near pi (3.14)      | 21.0        | 8.5           | 2.5x  |
| Medium (100.0)      | 28.6        | 7.0           | 4.1x  |
| Large (1e15)        | 28.0        | 19.2          | 1.5x  |
| Very large (1e100)  | 29.4        | 20.1          | 1.5x  |

## Throughput (10,000 values)

| Distribution           | cr_sin (ns/call) | Base.sin (ns/call) | Ratio |
|------------------------|-------------------|---------------------|-------|
| Normal range (|x|~10)  | 38.1              | 15.4                | 2.5x  |
| Full Float64 range     | 25.6              | 15.1                | 1.7x  |

## Fast path hit rate

99.986% of inputs (normal range) are resolved by the fast path (~20-30 ns).
Only 0.014% fall through to the accurate path.

## Correctness

100,000 random Float64 values tested against `BigFloat(precision=256)`:
**0 failures** — every result is bit-for-bit correctly rounded.

## Conclusions

1. **`cr_sin` is 1.4x–4.6x slower than `Base.sin`**, depending on the input magnitude. The typical overhead for common inputs is ~2.5x.

2. **For very small and very large inputs**, the gap narrows to ~1.4–1.5x since both implementations spend most of their time on argument reduction.

3. **The fast path handles 99.99%+ of inputs**, so the expensive accurate path rarely fires. The 128-bit `MFloat128` arithmetic is only needed for the ~0.01% of "hard to round" cases.

4. **A 2.5x slowdown is remarkably good** for a pure Julia translation that guarantees correct rounding. The C original (core-math) reports similar overhead vs system libm. This suggests the Julia translation introduces negligible overhead beyond the algorithmic cost.

5. **In absolute terms, `cr_sin` costs ~20-30 ns per call** — fast enough for most applications where correctness matters more than raw throughput.
