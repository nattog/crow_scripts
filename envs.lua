-- volkslied
--
-- linked AR shape envelopes
-- trigger in cv 1
-- time in cv 2
-- envelopes out 1-4
-- time * output index

function init()
    input[1] {
        mode = "change",
        threshold = 1.0,
        hysteresis = 0.2,
        direction = "rising"
    }

    input[2] {
        mode = "stream",
        time = 0.1
    }
end

shapes = {
    "linear",
    "sine",
    "logarithmic",
    "exponential"
}
time = 1

currentShape = 4

get_time = function(time, index)
    return time * index
end

for i = 1, 4 do
    env = ar(0.01, get_time(time, i))
    output[i].action = env
end

trigger = function(state)
    for i = 1, 4 do
        if output[i].running then
            output[i]("release")
        end

        output[i](state)
    end
end

update = function(value)
    time = value
end

input[1].change = trigger

input[2].stream = update
