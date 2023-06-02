vsim -gui -l msim_transcript {work.LevelPulse} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/LevelPulse/in
add wave -position end sim:/LevelPulse/clk
add wave -position end sim:/LevelPulse/pulse

force -freeze sim:/LevelPulse/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/LevelPulse/in 0 0

echo "Check if pulse stays low with low input"
run 100ps

echo "Check if pulse fires with posedge"
force -freeze sim:/LevelPulse/in 1 0
run 100ps

echo "Check if pulse stays low with high input"
run 100ps

echo "Check if pulse fires with negedge"
force -freeze sim:/LevelPulse/in 0 0 
run 100ps