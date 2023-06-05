vsim -gui -l msim_transcript {work.Choose} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Choose/pulse_i
add wave -position end sim:/Choose/choice
add wave -position end sim:/Choose/confirm
add wave -position end -unsigned sim:/Choose/num
add wave -position end -unsigned sim:/Choose/score
add wave -position end sim:/Choose/clk
add wave -position end -unsigned sim:/Choose/result
add wave -position end sim:/Choose/pulse_o
add wave -position end -unsigned sim:/Choose/new_score

force -freeze sim:/Choose/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Choose/pulse_i 0 0
force -freeze sim:/Choose/choice 0 0
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/score 10#5 0

echo "Check if wait does nothing"
run 500ps

echo "Check if skip occurs for num == 6"
force -freeze sim:/Choose/num 10#6 0 
force -freeze sim:/Choose/pulse_i 1 0
run 100ps

force -freeze sim:/Choose/pulse_i 0 0
run 100ps

echo "Check if wait does nothing (again)"
run 500ps

echo "Check if state moves to choose for num != 6"
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0 
force -freeze sim:/Choose/pulse_i 1 0
run 100ps

echo "Check if wait for choice"
force -freeze sim:/Choose/pulse_i 0 0
run 500ps

echo "Confirm choice (don't keep, continue) - pulse shouldn't fire until release"
force -freeze sim:/Choose/confirm 1 0
run 500ps

echo "Check if state moves to choose for num != 6"
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0 
force -freeze sim:/Choose/pulse_i 1 0
run 100ps

echo "Check if wait for choice"
force -freeze sim:/Choose/pulse_i 0 0
run 500ps

echo "Confirm choice (keep, continue) - pulse shouldn't fire until release"
force -freeze sim:/Choose/choice 1 0
force -freeze sim:/Choose/confirm 1 0
run 500ps

echo "Check if state moves to choose for num != 6"
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/score 10#12 0
force -freeze sim:/Choose/pulse_i 1 0
run 100ps

echo "Check if wait for choice"
force -freeze sim:/Choose/pulse_i 0 0
run 500ps

echo "Confirm choice (keep, lose) - pulse shouldn't fire until release"
force -freeze sim:/Choose/choice 1 0
force -freeze sim:/Choose/confirm 1 0
run 500ps

echo "Check if state moves to choose for num != 6"
force -freeze sim:/Choose/confirm 0 0
force -freeze sim:/Choose/num 10#4 0
force -freeze sim:/Choose/score 10#11 0
force -freeze sim:/Choose/pulse_i 1 0
run 100ps

echo "Check if wait for choice"
force -freeze sim:/Choose/pulse_i 0 0
run 500ps

echo "Confirm choice (keep, win) - pulse shouldn't fire until release"
force -freeze sim:/Choose/choice 1 0
force -freeze sim:/Choose/confirm 1 0
run 500ps

echo "Idle"
run 500ps