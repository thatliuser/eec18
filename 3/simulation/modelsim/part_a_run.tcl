for {set i 0} {$i < 16} {incr i} {
    force -drive {sim:/part_a /SW} 10#$i 0
    run 20 ns
    # Wait for input so I can show the TA before proceeding
    gets stdin
}