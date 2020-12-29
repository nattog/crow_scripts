t = ii.wtape
function init()
    metro[1].event = sync
    metro[1].time = 0.2
    metro[1]:start()
    output[2].action = ar(0.01, 2.5)
    metro[2].event = shift
    metro[2].time = 1.6
    metro[2]:start()
    t.play(1)
    t.record(1)
end
lydian = {0, 2, 4, 5, 6, 7, 9, 11}
penta = {0, 2, 4, 7, 9}
penta2 = {2, 4, 6, 9, 11}
scale_ix = 1
scale = lydian
level = 3
counter = 0
function sync()
    counter = counter + 1
    looping()
    n()
end
function looping()
    -- if counter == 16 then
    --     t.loop_start()
    -- elseif counter == 32 then
    --     t.loop_end()
    --     t.loop_active(1)
    -- end
end
function shift()
    scale = scale == penta and penta2 or penta
end
function n()
    for n = 1, 1 do
        scale_ix = (scale_ix + 2) % #scale + 1
        local note = scale[scale_ix] / 12
        output[1].volts = note
        output[2]()
    end
end
