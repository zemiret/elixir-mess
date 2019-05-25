# plot.gp
# output to png with decend font and image size
set terminal png font "Arial,10" size 700,500
set output "out/loading_small.png"

set title "Loading"
set xlabel "Trial"
set ylabel "Time"

# plot series (see below for explanation)
# plot [file] with [line type] ls [line style id] [title ...  | notitle]

plot  "benchmarks/loading_enum-inbox_small"    with points   ls 1 title "Enum small",\
      "benchmarks/loading_flow-inbox_small"  with points   ls 2 title "Flow small",\

set output "out/loading_big.png"
plot  "benchmarks/loading_enum-inbox_big"    with points   ls 1 title "Enum big",\
      "benchmarks/loading_flow-inbox_big"  with points   ls 2 title "Flow big",\

set output "out/loading_very_big.png"
plot  "benchmarks/loading_enum-inbox_very_big"    with points   ls 1 title "Enum very big",\
      "benchmarks/loading_flow-inbox_very_big"  with points   ls 2 title "Flow very big",\


set title "Msg counting"
set key top left # put labels in top-left corner

set output "out/total_small.png"
plot  "benchmarks/total_enum-inbox_small"    with points   ls 1 title "Enum small",\
      "benchmarks/total_flow-inbox_small"  with points   ls 2 title "Flow small",\

set output "out/total_big.png"
plot  "benchmarks/total_enum-inbox_big"    with points   ls 1 title "Enum big",\
      "benchmarks/total_flow-inbox_big"  with points   ls 2 title "Flow big",\

set output "out/total_very_big.png"
plot  "benchmarks/total_enum-inbox_very_big"    with points   ls 1 title "Enum very big",\
      "benchmarks/total_flow-inbox_very_big"  with points   ls 2 title "Flow very big",\


set title "Most frequent 100"
set key top left # put labels in top-left corner

set output "out/frequent_small.png"
plot  "benchmarks/frequent_enum-inbox_small"    with points   ls 1 title "Enum small",\
      "benchmarks/frequent_flow-inbox_small"  with points   ls 2 title "Flow small",\

set output "out/frequent_big.png"
plot  "benchmarks/frequent_enum-inbox_big"    with points   ls 1 title "Enum big",\
      "benchmarks/frequent_flow-inbox_big"  with points   ls 2 title "Flow big",\

set output "out/frequent_very_big.png"
plot  "benchmarks/frequent_enum-inbox_very_big"    with points   ls 1 title "Enum very big",\
      "benchmarks/frequent_flow-inbox_very_big"  with points   ls 2 title "Flow very big",\