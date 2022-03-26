-- plays wsyn

ws = ""
notes = {7, 5, 7, 12}
counter = 1
oct = 0
velocity = 5
velocity_min = 1

function init()
    input[1].mode('change',1.0,0.1,'rising')
    
    ws = ii.wsyn
    ws.ar_mode(1)
    ws.fm_ratio(1, 1)
    ws.fm_env(1)
    ws.fm_index(1)
end

input[1].change = function()
    velocity = input[2].volts
    new_note = notes[(counter % #notes) + 1]
    ws.play_note((new_note / 12) + oct, velocity + velocity_min)
    counter = counter + 1
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

function fm_ratio(num, denom)
    ws.fm_ratio(num, denom)
end
