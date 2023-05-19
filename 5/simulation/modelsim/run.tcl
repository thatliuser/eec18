# Configure CLK
force -freeze sim:/moore/MAX10_CLK1_50 1 0, 0 {50 ps} -r 100
force -drive {sim:/moore/KEY[0]} 1 0
force -drive {sim:/moore/KEY[1]} 0 0

# Run 2 iterations (0 -> 6, 6 -> 1)
echo "Testing 2 cycles"
run 1500 ps

# Try reset
force -drive {sim:/moore/KEY[0]} 0 0
echo "Testing reset"
run 100 ps
