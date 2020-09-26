--- fixed attenuators
-- in1: voltage to attenuate
-- in2: voltage offset
-- out1-4: voltage divided by output number + offset

function divideBy(v, i)
    return v / i
end

function attenuateWithOffset(v)
    for i = 1, 4 do
        output[i].volts = divideBy(v, i) + input[2].volts
    end
end

input[1].stream = function(volts)
    attenuateWithOffset(volts)
end

function init()
    input[1].mode("stream", 0.005)
    print("fixed attenuators loaded")
end
