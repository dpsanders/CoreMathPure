# CoreMathPure.jl

Pure Julia implementation of correctly-rounded math functions, translated from the [core-math](https://core-math.gitlabpages.inria.fr/) C library (MIT license, by Paul Zimmermann, Tom Hubrecht et al.).

Unlike `Base.sin`, which provides *faithful rounding* (off by at most 1 ULP), `cr_sin` guarantees **correct rounding** -- the returned `Float64` is the nearest floating-point number to the true mathematical result.

## Installation

```julia
using Pkg
Pkg.add(url="https://github.com/dpsanders/CoreMathPure.git")
```

## Usage

```julia
using CoreMathPure

cr_sin(1.0)   # 0.8414709848078965
cr_sin(0.5)   # 0.479425538604203
```

## Correctness

100,000 random `Float64` values tested against `sin(BigFloat(x, precision=256))`: **0 failures** -- every result is bit-for-bit correctly rounded.

## Performance

Benchmarked on Julia 1.10 / Apple Silicon:

| Input range | `cr_sin` | `Base.sin` | Ratio |
|---|---|---|---|
| Typical (1.0) | 21 ns | 9 ns | 2.4x |
| Throughput (10k values) | 38 ns/call | 15 ns/call | 2.5x |

The fast path handles ~99.99% of inputs using double-double arithmetic. Only the remaining ~0.01% of hard-to-round cases fall through to 128-bit (`DInt64`) arithmetic.

See [BENCHMARK.md](BENCHMARK.md) for full results.

## How it works

Two-phase argument reduction and evaluation:

1. **Fast path**: Double-double (~106-bit) arithmetic with precomputed sin/cos tables at multiples of 2pi/2048. Degree-7/6 polynomial for the residual. Returns immediately if the error bound proves rounding is unambiguous.

2. **Accurate path**: 128-bit floating-point (`DInt64`) arithmetic with degree-11/10 polynomials. Two known hard-to-round exceptions handled explicitly.

Argument reduction uses a 1280-bit approximation of 1/(2pi).

See [TRANSLATION.md](TRANSLATION.md) for the C-to-Julia mapping.

## Currently implemented

- `cr_sin(::Float64)` -- correctly-rounded sine

## License

The original C code is from the [core-math project](https://core-math.gitlabpages.inria.fr/) (MIT license). This Julia translation is also MIT licensed.

## Acknowledgements

Based on the `sin` implementation from [core-math](https://gitlab.inria.fr/core-math/core-math) by Paul Zimmermann and Tom Hubrecht.
