vsim -gui -l msim_transcript {work.\3 } -L altera_ver -L fiftyfivenm_ver
radix -hexadecimal
add wave -position insertpoint  \
{sim:/\3 /HEX0}
add wave -position insertpoint  \
{sim:/\3 /HEX1}
add wave -position insertpoint -binary  \
{sim:/\3 /SW}