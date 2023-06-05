vsim -gui -l msim_transcript {work.Roll} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Roll/btn
add wave -position end sim:/Roll/clk
add wave -position end sim:/Roll/enable
add wave -position end -unsigned sim:/Roll/num
add wave -position end sim:/Roll/choose

force -freeze sim:/Roll/clk 1 0, 0 {50 ps} -r 100

echo "Check if frozen when enable is low"
force -freeze sim:/Roll/enable 0 0
force -freeze sim:/Roll/btn 1 0
run 300ps

echo "Check if num stays 0 when btn isn't pressed"
force -freeze sim:/Roll/enable 1 0
force -freeze sim:/Roll/btn 0 0
run 300ps

echo "Check a couple roll cycles"
force -freeze sim:/Roll/btn 1 0
run 1400ps

echo "Check releasing btn in roll cycle"
force -freeze sim:/Roll/btn 0 0
run 300ps

echo "Check if num resets to 0 on \"negedge enable\""
force -freeze sim:/Roll/enable 0 0
run 300ps

echo "Enable again, check if num stays 0 when btn isn't pressed"
force -freeze sim:/Roll/enable 1 0
force -freeze sim:/Roll/btn 0 0
run 300ps

echo "Check a couple roll cycles, ensure num starts from 0"
force -freeze sim:/Roll/btn 1 0
run 1400ps

echo "Check releasing btn, again"
force -freeze sim:/Roll/btn 0 0
run 300ps