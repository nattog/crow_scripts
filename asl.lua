-- asl lua

notes = {3, 21, 51}
scale={1, 2, 3, 4, 5, 6, 8, 9, 10, 11, 12}
temperament = 6
counter = 1
scaling = 1
function init()
    input[1].mode('change',1.0,0.1,'rising')
    output[2].action = pulse()
    output[3].action = lfo(20, 2, "linear")
    output[3]();
      -- scale: a table of note values, eg: {0,2,3,5,7,9,10}
      --        use the empty table {} for chromatic scale
      -- temperament: how many notes in a scale, default 12 (ie 12TET)
end


input[1].change = function()
    step()
end

function n2v(n)
    return asl.runtime( function(a) return a/12 end
                      , n
                      )
end



function play(n)
    output[1](to(function() return n2v(n) end))
    output[2]()
end

function step()
    current = notes[(counter % #notes) +1 ]
    play(current)
    counter = counter + 1
end