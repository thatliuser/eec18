proc addAlias {signal alias size} {
    for {set i 0} {$i < $size} {incr i} {
        set symbol [format "sim:/Game/%s\[%s\]" $signal $i]
        add wave -position end -group $alias $symbol
    }
}

proc setButton {on} {
    # Low active
    set drive [expr $on == 1 ? 0 : 1]
    force -freeze sim:/Game/KEY\[0\] $drive
}

proc setSwitch {on} {
    force -freeze sim:/Game/SW\[0\] $on
}

# Short for simulate
proc sim {time msg} {
    echo $msg
    run $time
    # Wait for user input since this simulation is super long
    gets stdin
}

proc roll {time} {
    setButton 0
    sim 500ps "State should be 1 and roll should wait"

    setButton 1
    sim $time "Hold button down, num should increment"
    
    setButton 0
    sim 100ps "Release button, state should be 2 and num should freeze"
}

proc choose {keep} {
    setButton 0
    setSwitch $keep
    sim 500ps "Ensure choose waits for user confirmation"

    setButton 1
    set msg [expr {$keep == 1 ? \
        "Keep number, ensure score goes up" \
        : "Don't keep number, ensure score stays same"}]
    sim 100ps $msg
}

vsim -gui -l msim_transcript {work.Game} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Game/MAX10_CLK1_50
add wave -position end sim:/Game/SW
add wave -position end sim:/Game/KEY
add wave -position end -hex sim:/Game/LEDR

addAlias HEX0 roll_num 3
addAlias HEX1 score 4
addAlias HEX2 turns 4
addAlias HEX3 state 2
addAlias HEX4 demux_out 4
addAlias HEX5 ctrl_pulses 4

force -freeze sim:/Game/MAX10_CLK1_50 1 0, 0 {50 ps} -r 100
setSwitch 0

setButton 0
sim 100ps "Ensure state is 0 with no button press"

setButton 1
sim 500ps "Hold down button, state should stay at 0"

roll 500ps
choose 0

roll 500ps
choose 1
