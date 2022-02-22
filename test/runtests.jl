using Test
using RadioHead

c = Coax(15.0, 0.8)

@testset "units" begin
    
    m = Meter(2.0)
    @test toFeet(m).value == 3.2808f0 * 2
    @test toMeters(m).value == 1.0f0 * 2

    m = Foot(3.0)
    @test toMeters(m).value == 0.3048f0 * 3
    @test toFeet(m).value == 1.0f0 * 3

end

@testset "coax" begin

    @test c.centerFreq === 15.0f0
    @test c.velocityFactor === 0.8f0
    @test c.wavelengthUnit === 16.0
    
end
