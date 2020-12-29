--- fun with crow

seq = {
    {
        note = 0,
        octave = 1,
        gate = 1,
        time = 0.2,
        param = 3
    },
    {
        note = 0,
        octave = 2,
        gate = 1,
        time = 0.2,
        param = 2
    },
    {
        note = 2,
        octave = 3,
        gate = 1,
        time = 0.1,
        param = 5
    },
    {
        note = 3,
        octave = 2,
        gate = 1,
        time = 0.1,
        param = 0
    },
    {
        note = 0,
        octave = 3,
        gate = 1,
        time = 0.2,
        param = 2
    },
    {
        note = 0,
        octave = 3,
        gate = 0,
        time = 0.5,
        param = 3.5
    },
    {
        note = 0,
        octave = -1,
        gate = 0,
        time = 0.1,
        param = 0.2
    },
    {
        note = 3,
        octave = -1,
        gate = 1,
        time = 0.2,
        param = 3.4
    }
}
seq_idx = 1
prob = 50
myjourney = {
    to(1, 1),
    to(2, 2),
    to(3, 3)
}

-- some scales for later
penta = {0, 2, 4, 7, 9}
lydian = {0, 2, 4, 6, 7, 9, 11}
dorian = {0, 2, 3, 5, 7, 9, 10}
wholetone = {0, 2, 4, 6, 8, 10}
diminished = {0, 3, 6, 9}

function init()
    ii.wdel.mix(0.2)
    ii.wdel.feedback(0.2)
    d = ii.wdel
    output[1].scale(lydian)
    metro[1].event = step
    metro[1].time = 0.2
    metro[1]:start()
    output[2].action = pulse(0.1)
    output[4](myjourney)

    for i = 1, 8 do
        seq[i].time = 0.9 - (i / 10)
    end
end

function step()
    note = seq[seq_idx].note
    oct = seq[seq_idx].octave
    output[1].volts = ((seq[seq_idx].note / 12) + oct)
    if seq[seq_idx].gate == 1 then
        output[2]()
    end
    output[3].volts = seq[seq_idx].param
    metro[1].time = 0.2 + seq[seq_idx].time
    is_frozen = math.random() * 100 > prob and 1 or 0
    d.freeze(is_frozen)
    -- ii.wdel.time(0.9 - seq[seq_idx].time)
    seq_idx = (seq_idx % #seq) + 1
end

function update(index, option, value)
    seq[index].option = value
end
