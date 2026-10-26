set terminal pngcairo size 1600,900
set output '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.png'
set title 'xplane_log_b738_enva_enrm' noenhanced
set xlabel "Zulu time"
set ylabel "Altitude (ft) / airspeed (kt)"
set y2label "Speedbrake deployment (0-1)"
set y2range [0:1]
set y2tics 0, 0.2, 1
set ytics nomirror
set grid
set key outside right center
set xrange [40617.585:41591.818]
set xtics ('11:16:58Z' 40617.585, '11:20Z' 40800.000, '11:30Z' 41400.000, '11:33:12Z' 41591.818)
set arrow 1 from first 40999.418, graph 0 to first 40999.418, graph 1 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 2 from first 40912.931, graph 0 to first 40912.931, graph 1 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 3 from first 41013.831, graph 0 to first 41013.831, graph 1 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 4 from first 41115.458, graph 0 to first 41115.458, graph 1 nohead dt 2 lw 0.5 lc rgb '#888888' back
set label 1 'Gear Up' at first 40999.418, graph 0.025 center point pt 9 ps 1.2 offset 0,1
set label 2 'Flaps DOWN 50%' at first 40912.931, graph 0.08 center point pt 11 ps 1.2 offset 0,1
set label 3 'Flaps UP 25%' at first 41013.831, graph 0.08 center point pt 9 ps 1.2 offset 0,1
set label 4 'Flaps UP 0%' at first 41115.458, graph 0.08 center point pt 9 ps 1.2 offset 0,1
plot '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:2 with lines title 'Altitude (ft)', \
     '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:3 with lines axes x1y2 title 'Speedbrake (deployment ratio)'
