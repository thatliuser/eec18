vsim -gui -l msim_transcript {work.moore} -L altera_ver -L fiftyfivenm_ver
radix -hexadecimal
add wave -position insertpoint {sim:/moore/HEX0}
add wave -position insertpoint -binary {sim:/moore/KEY[0]}
add wave -position insertpoint -binary {sim:/moore/KEY[1]}
add wave -position insertpoint -binary {sim:/moore/MAX10_CLK1_50}
add wave -position insertpoint {sim:/moore/LEDR}
