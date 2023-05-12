vsim -gui -l msim_transcript {work.part_a } -L altera_ver -L fiftyfivenm_ver
radix -hexadecimal
add wave -position insertpoint  \
{sim:/part_a /HEX0}
add wave -position insertpoint  \
{sim:/part_a /HEX1}
add wave -position insertpoint -binary  \
{sim:/part_a /SW}