-- drummer
-- 4 track pattern sequencer
-- pattern notation looks like this 'x---x---x---x---'
-- update sequence track with set(track, pattern)
-- 
-- queue a new sequence
-- progress(seq table, period - by default 16)
--
-- control transport
-- start() stop() reset()

counter = 0 -- used to get index by modulo of seq items
seq = {"", "", "", ""}
pause = false
preset = {'x---', '----x---', '--x-', 'xx--x--'}
queued = {}
wait = 0

function init()
    -- set up input modes
    input[1].mode("change", 1, 0.1, "rising")
    input[2].mode("change", 1, 0.1, "rising")
    input[1].change = function() if pause == false then step() end end
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
    local to_print = ""
    for chan = 1, #seq do
        if chan <= 4 then
            if #seq[chan] > 0 then
                local step_idx = math.floor(counter % #seq[chan]) + 1
                local step_value = seq[chan]:sub(step_idx, step_idx)
                if step_value == 'x' then
                    output[chan]()
                end
                to_print = to_print .. (step_value == 'x' and step_value or "_") .. " "
            else 
                to_print = to_print .. "_ "
            end
        end
    end

    -- increments counter
    counter = counter + 1

    if #queued > 0 then
        -- countdown wait if queue has elements
        if wait > 0 then
            wait = wait - 1
        else 
            -- can set the queue
            seq = queued
            wait = 0
            queued = {}
        end
    end
    print(to_print)
end

function set(idx, val)
    -- sets all tracks to same val
    if idx == "*" then
        for i = 1, #seq do
            seq[i] = #val > 0 and val or ''
        end
    end
        
    -- only set sequences for valid output indexes
    if idx < 5 and idx > 0 then
        seq[idx] = #val > 0 and val or ''
    end

    print('\n')
    print('SET ' .. idx .. ' TO ' .. string.upper(seq[idx]))
    print('\n')
end

function stop()
    pause = true
end

function start()
    pause = false
end

function progress(tab, period)
    local progress_on = period or 16
    if tab == nil then
        print('no input')
        return
    end
    -- if input is empty table, set all channels to empty strings
    local new_seq = #tab < 1 and {"", "", "", ""} or tab

    -- if running then a wait period is necessary
    if pause == false then
        wait_period = progress_on % counter 
        -- add seq to queue
        if wait_period ~= 0 then
            queued = new_seq
            wait = wait_period
        else
            seq = new_seq
        end
    else 
        -- update seq
        seq = new_seq
        reset()
    end
end