-- plays wsyn

ws = ""

function init()
    output[1].mode = pulse()
    metro[2].event = function()
        increment_every(0.2, 0.3)
    end
    metro[2].time = 2
    metro[2]:start()
    ws = ii.wsyn
    ws.ar_mode(1)
end

function sync()
    counter = counter + 1
    looping(counter, 16)
    n()
    running()
end


incr1 = 0.6
incr2 = 0.1
function increment_every(val1, val2)
    incr1 = incr1 + val1
    incr2 = incr2 + val2
    if incr1 > 8 then 
        incr1 = 1
    end

    if incr2 > 4 then
        incr2 = 1
    end
    ws.fm_ratio(incr1, incr2)
end

function looping(counter, len)
    if counter % len == 0 then
        
        -- shifts_ix = (shifts_ix + 1) % #shifts + 1
    end
end

function find_position_in_running(from, to, count, wrap)
    min = math.min(from, to)
    max = math.max(to, from)
    step_amt = (max - min) / wrap
    pos = count % wrap
    return (min + pos * step_amt)
end

function running()
    for n = 1, #running_items do
        current = running_items[n]
        from, to, wrap = current[2], current[3], current[4]
        current[1](find_position_in_running(from, to, counter - 1, wrap))
    end
end

function ar(is_ar)
    ws.ar_mode(is_ar)
end

function ramp(amt)
    ws.ramp(amt)
end

function curve(amt)
    ws.curve(amt)
end

function fm_env(amt)
    ws.fm_env(amt)
end

function fm_index(amt)
    ws.fm_index(amt)
end

function fm_ratio(amt)
    ws.fm_ratio(amt)
end

function update_scale(newscale)
    scale_ix = 1
    scale = newscale
end

function get_random_note(scale)
    octave = math.floor(math.random(2)) - 1
    return octave + ((scale[math.floor(math.random(#scale))] + shifts[shifts_ix]) / 12)
end

function n()
    for n = 1, 1 do
        scale_ix = (scale_ix + 2) % #scale + 1
        local note = (scale[scale_ix] + shifts[shifts_ix]) / 12
        if counter % 2 ~= 0 then
            if true then
                local rand = get_random_note(scale)
                ws.lpg_symmetry(rand > 1 and 0 or -10)
            -- ws.play_note(rand, 3)
            end
            ws.lpg_symmetry(1)
        end
        -- if math.random() < prob then
        ws.play_note(note, 5)
        -- end
    end
end
