proc toBinStr {num width} {
    binary scan [binary format "I" $num] "B*" binval
    return [string range $binval end-$width end]
}

for {set i 0} {$i < 16} {incr i} {
    # Range is 2^3 - 1 = 7
    set a [expr {int(rand() * 7)}]
    set b [expr {int(rand() * 7)}]
    # Range is 0 or 1
    set c [expr {int(rand() * 1.999)}]
    set str $c 
    append str [toBinStr $b 2]
    append str [toBinStr $a 2]
    
    puts [format "%s (a) + %s (b) + %s (c) = %x?" $a $b $c [expr {$a + $b + $c}]]
    puts $str
    force -drive {sim:/part_b /SW} 2#$str 0
    run 20 ns
    # Wait for input so I can show the TA before proceeding
    gets stdin
}
