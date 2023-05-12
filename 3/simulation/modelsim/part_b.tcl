vsim -gui -l msim_transcript {work.part_b} -L altera_ver -L fiftyfivenm_ver
radix -hexadecimal
add wave -position insertpoint {sim:/part_b /LEDR}
add wave -position insertpoint -octal {sim:/part_b /SW}
