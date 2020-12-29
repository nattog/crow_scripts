function init()
    output[1].action = pulse()
    metro[1].event = step
    metro[1].time = 0.2
    metro[1]:start()
end

function step()
    print(input[1].volts)
    output[1]()
end
