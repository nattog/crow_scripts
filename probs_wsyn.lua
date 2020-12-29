--- gate probs
-- in1: clock input
-- out1-4: 100% 75% 50% 25%

-- private vars
count = {1, 1, 1, 1}

nums = {0, 2, 2, 3, 3, 5, 7, 7, 8, 8, 10, 10, 12}
pos = -1
voltdiv = 1 / 12

changethreshold = 0.001
last_value = 0

function process_stream(v)
  if math.abs(last_value - v) > changethreshold then
    print("changed")
    ii.wsyn.fm_ratio(math.random() * 5 + v)
    last_value = v
  end
end

function init()
  input[1].mode("change")
  input[2].stream = process_stream
  input[2].mode("stream", 0.01)
  for n = 1, 4 do
    output[n].slew = 0.001
  end

  ii.wsyn.ar_mode(1)
end

input[1].change = function(s)
  for n = 1, 4 do
    if math.random() * 100 <= 100 / n then
      local position = (pos + n) % (#nums - 1)
      ii.wsyn.play_note(nums[position + 1] / 12, 5)
    end
  end
  pos = ((pos + 1) % (#nums - 1))
end
