-- drummer
-- uses sequence notation like this 'x---x---x---x---'
-- by setting command seq[output_no] = 'x--'

local counter = 0 -- used to get index by modulo of seq items
seq = {
    "", "", "", ""
}

function init()
    -- set up input modes
    input[1].mode("change", 1, 0.1, "rising")
    input[2].mode("change", 1, 0.1, "rising")
    input[1].change = step
    input[2].change = reset

    -- set up output modes
    for i = 1, 4 do 
        output[i].action = pulse(0.02,8)
    end
end

-- resets counter variable to initial value
function reset()
    counter = 0
end 

-- update counter and trigger for each 'x' found at index of each seq
function step()
    counter = counter + 1
    for chan = 1, #seq do
        if chan <= 4 then
            if #seq[chan] > 0 then
                local step_idx = math.floor(counter % #seq[chan]) + 1
                local step_value = seq[chan]:sub(step_idx, 1)
                if step_value == 'x' then
                   print('triggers -> ' .. chan)
                   output[chan]()
                end
            end
        end
    end
end

function set(idx, val)
    if idx == "*" then
        for i = 1, #seq do
            seq[i] = #val > 0 and val or ''
        end
    end
        
    if idx < 5 and idx > 0 then
        seq[idx] = #val > 0 and val or ''
    end
end
