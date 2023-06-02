vsim -gui -l msim_transcript {work.Demux4} -L altera_ver -L fiftyfivenm_ver
add wave -position end sim:/Demux4/in
add wave -position end sim:/Demux4/sel
add wave -position end sim:/Demux4/out

for {set i 0} {$i < 4} {incr i} {
    echo "Testing select input $i"
    force -drive sim:/Demux4/sel 10#$i 0
    run 100ps
}
