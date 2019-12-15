--- gate probs
-- in1: clock input
-- out1-4: 100% 75% 50% 25%

-- private vars
count = {1, 1, 1, 1}
function init()
  input[1].mode("change")
  input[2].mode("none")
  for n = 1, 4 do
    output[n].slew = 0.001
  end
end

input[1].change = function(s)
  print("s")
  for n = 1, 4 do
    if math.random() * 100 <= 100 / n then
      output[n](pulse(0.01, 8))
    end
  end
end
