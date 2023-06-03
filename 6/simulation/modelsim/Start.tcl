vsim -gui -l msim_transcript {work.Start} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Start/btn
add wave -position end sim:/Start/clk
add wave -position end sim:/Start/start

force -freeze sim:/Start/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Start/btn 0 0

echo "Check if pulse stays low with low input"
run 100ps

echo "Check if pulse fires with posedge"
force -freeze sim:/Start/btn 1 0
run 100ps

echo "Check if pulse stays low with high input"
run 100ps

echo "Check if pulse fires with negedge"
force -freeze sim:/Start/btn 0 0 
run 100ps

echo "Check if pulse stays low with low input"
run 100ps