module RadioHead
export Coax, computeLength, Unit, toMeters, toFeet, toString, Foot, Meter, partial

abstract type Unit end

mutable struct Meter <: Unit
    value::Float32
end

mutable struct Foot <: Unit
    value::Float32
end

mutable struct Coax
    centerFreq::Float32
    velocityFactor::Float32
    # unit is meters
    wavelengthUnit
    function Coax(centerFreq::Float64, velocityFactor::Float64)
        # centerFreq is center of desired band in mHz
        wlu = (300 / centerFreq) * velocityFactor
        new(centerFreq, velocityFactor, wlu)
    end
end

function partial(divisor::Int64, c::Coax)
    return Meter(c.wavelengthUnit / divisor)
end

function computeLength(approxLength::Unit, c::Coax)
    # approxLength is in meters
    # waveLengths = ceil.(toMeters(approxLength).value ./ c.wavelengthUnit)
    waveLength = ceil(toMeters(approxLength).value / c.wavelengthUnit)
    coaxLength = Meter(waveLength * c.wavelengthUnit)
    tc = typeof(approxLength)
    if tc == Meter
        return coaxLength
    else
        return toFeet.(coaxLength)
    end
end

function toMeters(u)
    # convert u to meters
    return Meter(conversion_factor(typeof(u), Meter) * u.value)
end

function toFeet(u)
    # convert u to feet
    return Foot(conversion_factor(typeof(u), Foot) * u.value)
end

function conversion_factor(from_u, to_u)
    # x = []
    # x[Meter, Foot] = 3.2808
    # x[Foot, Meter] = 0.3048
    if from_u == Meter && to_u == Foot
        return 3.2808
    elseif from_u == Foot && to_u == Meter
        return 0.3048
    else
        return 1.0
    end
end

function toString(t::Any)
    tc = typeof(t)
    if tc == Meter
        return string(t.value) * " m"
    elseif tc == Foot
        return string(t.value) * " ft"
    elseif tc == Coax
        return "cf " * string(t.centerFreq) * " vf " * string(t.velocityFactor)
    end
    return ""
end

end # module
