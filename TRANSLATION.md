# CoreMathPure: Pure Julia translation of core-math

## What this is

A pure Julia translation of the [core-math](https://core-math.gitlabpages.inria.fr/) C library's
correctly-rounded `sin(::Float64)` function. The C original is ~2090 lines in
`src/binary64/sin/sin.c` by Paul Zimmermann and Tom Hubrecht (MIT license).

## Status

- `cr_sin(::Float64)` — fully working, passes 100k random tests against BigFloat with
  **zero failures** (bit-for-bit correctly rounded).

## How it works

The algorithm has two paths:

1. **Fast path** (`sin_fast`): Uses double-double arithmetic (~106-bit precision) with
   precomputed tables `SC[256]` for sin/cos at multiples of `2π/2048`. A degree-7/6
   polynomial evaluates sin2π/cos2π of the residual. If the error bound proves the
   rounding is unambiguous, return immediately (~99.998% of inputs).

2. **Accurate path** (`sin_accurate`): Falls back to 128-bit floating-point (`MFloat128`)
   arithmetic with degree-11/10 polynomials and tables `S[256]`, `C[256]`. Two known
   hard-to-round exceptions are handled explicitly.

Argument reduction uses a 1280-bit approximation of `1/(2π)` stored in `T[20]`.

## File structure

```
CoreMathPure/
├── Project.toml
├── TRANSLATION.md          ← this file
├── gen_tables.jl           ← script to extract tables from C source
├── extract_tables.jl       ← alternative extraction script
├── src/
│   ├── CoreMathPure.jl     ← module definition
│   ├── mfloat128.jl        ← MFloat128 type (128-bit float) + arithmetic
│   ├── sin_tables.jl       ← auto-generated lookup tables (~840 lines)
│   └── sin.jl              ← cr_sin: fast path, accurate path, entry point
└── test/
    └── runtests.jl         ← 54 tests including BigFloat correctness checks
```

## Translation approach

### Phase 1: Line-by-line translation (done)

Direct C-to-Julia mapping:

| C                           | Julia                                      |
|-----------------------------|---------------------------------------------|
| `unsigned __int128`         | `UInt128`                                   |
| `dint64_t` (union)          | `struct MFloat128` (immutable, 4 fields)       |
| `__builtin_clzll(x)`       | `leading_zeros(x)`                          |
| `__builtin_fma(a,b,c)`     | `fma(a,b,c)`                                |
| `f64_u` union               | `reinterpret(UInt64, x)` / `reinterpret(Float64, u)` |
| Pointer mutation (`*r = …`) | Return new values (functional style)        |
| `fegetround()`              | Hardcoded round-to-nearest (Julia default)  |
| `T[i]` (0-indexed)         | `T_TABLE[i+1]` (1-indexed)                 |

Tables were extracted programmatically from the C source via `gen_tables.jl`
(regex-based extraction of hex literals), not transcribed by hand.

### Phase 2: Idiomatic Julia (next)

- Use Julia naming conventions (snake_case, no `_TABLE` suffixes where clear)
- Replace manual bit manipulation with Julia idioms where possible
- Use `@inline` and type annotations judiciously
- Consider using `Base.BitInteger` operations
- Make `MFloat128` arithmetic feel natural with operator overloading
- Add docstrings
