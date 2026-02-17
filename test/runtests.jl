using Test
using CoreMathPure

@testset "CoreMathPure cr_sin" begin
    @testset "Special values" begin
        @test cr_sin(0.0) === 0.0
        @test cr_sin(-0.0) === -0.0
        @test isnan(cr_sin(NaN))
        @test isnan(cr_sin(Inf))
        @test isnan(cr_sin(-Inf))
    end

    @testset "Tiny values (sin(x) ≈ x)" begin
        @test cr_sin(1e-300) === 1e-300
        @test cr_sin(-1e-300) === -1e-300
        @test cr_sin(5e-324) === 5e-324  # smallest subnormal
    end

    @testset "Exact values" begin
        @test cr_sin(0.0) === 0.0
    end

    @testset "Correctly rounded (vs BigFloat)" begin
        for x in [0.1, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0, 3.14, 6.0, 6.28,
                   100.0, 1000.0, 1e15, 0x1p-20, 0x1p-10]
            exact = Float64(sin(BigFloat(x, precision=256)))
            @test cr_sin(x) === exact
            exact_neg = Float64(sin(BigFloat(-x, precision=256)))
            @test cr_sin(-x) === exact_neg
        end
    end

    @testset "Near multiples of pi" begin
        for k in 1:10
            x = k * Float64(pi)
            result = cr_sin(x)
            exact = Float64(sin(BigFloat(x, precision=256)))
            @test result === exact
        end
    end

    @testset "Random values" begin
        rng = [0x3ff0000000000000,  # 1.0
               0x400921fb54442d18,  # pi
               0x4005bf0a8b145769,  # 2.718...
               0x4059000000000000,  # 100.0
               0x40f86a0000000000,  # 100000.0
               ]
        for u in rng
            x = reinterpret(Float64, u)
            exact = Float64(sin(BigFloat(x, precision=256)))
            @test cr_sin(x) === exact
        end
    end
end
