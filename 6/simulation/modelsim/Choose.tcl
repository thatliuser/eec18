vsim -gui -l msim_transcript {work.Choose} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Choose/wake
add wave -position end sim:/Choose/keep
add wave -position end sim:/Choose/confirm
add wave -position end -unsigned sim:/Choose/num
add wave -position end -unsigned sim:/Choose/score
add wave -position end sim:/Choose/clk
add wave -position end sim:/Choose/rstn
add wave -position end -unsigned sim:/Choose/pulse
add wave -position end -unsigned sim:/Choose/scorep
add wave -position end -unsigned sim:/Choose/state

proc sim {time msg} {
    echo $msg
    run $time
    # Wait for user input since this simulation is super long
    gets stdin
}

force -freeze sim:/Choose/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Choose/wake 0 0
force -freeze sim:/Choose/rstn 1 0
force -freeze sim:/Choose/keep 0 0
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/score 10#5 0

sim 500ps "Check if wait does nothing"

force -freeze sim:/Choose/num 10#6 0
force -freeze sim:/Choose/wake 1 0
sim 100ps "Check if skip occurs for num == 6"

force -freeze sim:/Choose/wake 0 0
run 100ps

sim 500ps "Check if wait does nothing (again)"

force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/wake 1 0
sim 100ps "Check if state moves to choose for num != 6"

force -freeze sim:/Choose/wake 0 0
sim 500ps "Check if wait for choice"

force -freeze sim:/Choose/confirm 1 0
sim 500ps "Confirm choice (don't keep, continue) - pulse shouldn't fire until release"

force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/wake 1 0
sim 100ps "Check if state moves to choose for num != 6"

sim 500ps "Check if wait for choice"
force -freeze sim:/Choose/wake 0 0

sim 500ps "Confirm choice (keep, continue) - pulse shouldn't fire until release"
force -freeze sim:/Choose/keep 1 0
force -freeze sim:/Choose/confirm 1 0

force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/score 10#12 0
force -freeze sim:/Choose/wake 1 0
sim 100ps "Check if state moves to choose for num != 6"

force -freeze sim:/Choose/wake 0 0
sim 500ps "Check if wait for choice"

force -freeze sim:/Choose/keep 1 0
force -freeze sim:/Choose/confirm 1 0
sim 500ps "Confirm choice (keep, lose) - pulse shouldn't fire until release"

force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/score 10#11 0
force -freeze sim:/Choose/wake 1 0
sim 100ps "Check if state moves to choose for num != 6"

force -freeze sim:/Choose/wake 0 0
sim 500ps "Check if wait for choice"

force -freeze sim:/Choose/keep 1 0
force -freeze sim:/Choose/confirm 1 0
sim 500ps "Confirm choice (keep, win) - pulse shouldn't fire until release"

force -freeze sim:/Choose/confirm 0 0
sim 500ps "Idle"
