vsim -gui -l msim_transcript {work.Control} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Control/pulse_i
add wave -position end -unsigned sim:/Control/choose_result
add wave -position end sim:/Control/clk
add wave -position end sim:/Control/pulse_o
add wave -position end sim:/Control/won
add wave -position end -unsigned sim:/Control/turns
add wave -position end -unsigned sim:/Control/state

force -freeze sim:/Control/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Control/pulse_i 0 0
force -freeze sim:/Control/choose_result 0 0

echo "Check if state stays at start with no pulse"
run 500ps

echo "Check if state switches to roll after start pulse"
force -freeze sim:/Control/pulse_i 1 0
run 100ps

echo "Check if state stays at roll with no pulse"
force -freeze sim:/Control/pulse_i 0 0
run 500ps

echo "Check if state switches to choose after roll pulse"
force -freeze sim:/Control/pulse_i 1 0
run 100ps

echo "Check if state stays at choose with no pulse"
force -freeze sim:/Control/pulse_i 0 0
run 500ps

echo "Check if state switches to roll after choose pulse (no win)"
force -freeze sim:/Control/pulse_i 1 0
run 100ps

echo "Check if state stays at roll with no pulse"
force -freeze sim:/Control/pulse_i 0 0
run 500ps

echo "Check if state switches to choose after roll pulse"
force -freeze sim:/Control/pulse_i 1 0
run 100ps

echo "Check if state stays at choose with no pulse"
force -freeze sim:/Control/pulse_i 0 0
run 500ps

echo "Check if state switches to end after choose pulse (won)"
force -freeze sim:/Control/choose_result 10#2 0
force -freeze sim:/Control/pulse_i 1 0
run 100ps

echo "Check if state stays at end with no pulse"
force -freeze sim:/Control/pulse_i 0 0
run 500ps

echo "Check if state stays at end with pulses"
force -freeze sim:/Control/pulse_i 1 0
run 500ps