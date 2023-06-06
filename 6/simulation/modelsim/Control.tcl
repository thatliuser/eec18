proc sim {time msg} {
    echo $msg
    run $time
    # Wait for user input since this simulation is super long
    gets stdin
}

vsim -gui -l msim_transcript {work.Control} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Control/wake
add wave -position end sim:/Control/done
add wave -position end sim:/Control/clk
add wave -position end sim:/Control/rstn
add wave -position end -unsigned sim:/Control/state

force -freeze sim:/Control/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Control/wake 0 0
force -freeze sim:/Control/done 0 0
force -freeze sim:/Control/rstn 1 0

sim 500ps "Check if state stays at start with no pulse"

force -freeze sim:/Control/wake 1 0
sim 100ps "Check if state switches to roll after start pulse"

force -freeze sim:/Control/wake 0 0
sim 500ps "Check if state stays at roll with no pulse"

force -freeze sim:/Control/wake 1 0
sim 100ps "Check if state switches to choose after roll pulse"

force -freeze sim:/Control/wake 0 0
sim 500ps "Check if state stays at choose with no pulse"

force -freeze sim:/Control/wake 1 0
sim 100ps "Check if state switches to roll after choose pulse (no win)"

force -freeze sim:/Control/wake 0 0
sim 500ps "Check if state stays at roll with no pulse"

force -freeze sim:/Control/wake 1 0
sim 100ps "Check if state switches to choose after roll pulse"

force -freeze sim:/Control/wake 0 0
sim 500ps "Check if state stays at choose with no pulse"

force -freeze sim:/Control/done 1 0
force -freeze sim:/Control/wake 1 0
sim 100ps "Check if state switches to end after choose pulse (won)"

force -freeze sim:/Control/wake 0 0
sim 500ps "Check if state stays at end with no pulse"

force -freeze sim:/Control/wake 1 0
sim 500ps "Check if state stays at end with pulses"
