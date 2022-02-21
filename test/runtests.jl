using Test
using RadioHead

c = Coax(15.0, 0.8)

@testset "coax" begin

    @test c.centerFreq === 15.0f0
    @test c.velocityFactor === 0.8f0
    @test c.wavelengthUnit === 16.0
    
end
