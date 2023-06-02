vsim -gui -l msim_transcript {work.Roll} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Roll/btn
add wave -position end sim:/Roll/clk
add wave -position end -unsigned sim:/Roll/num
add wave -position end sim:/Roll/choose

force -freeze sim:/Roll/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/Roll/btn 0 0

echo "Check if num stays 0 when btn isn't pressed"
run 300ps

echo "Check a couple roll cycles"
force -freeze sim:/Roll/btn 1 0
run 1400ps

echo "Check releasing btn in roll cycle"
force -freeze sim:/Roll/btn 0 0
run 300ps
