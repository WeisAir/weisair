set terminal pngcairo size 1600,900
set output '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.png'
set title 'xplane_log_b738_enva_enrm'
set xlabel "Zulu time"
set ylabel "Altitude (ft) / airspeed (kt)"
set y2label "Deployment (0-1)"
set y2range [0:1]
set y2tics 0, 0.2, 1
set ytics nomirror
set grid
set key outside right center
set xrange [40617.585:41591.818]
set xtics ('11:20Z' 40800.000, '11:25Z' 41100.000, '11:30Z' 41400.000)
plot '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:2 with lines title 'Pressure altitude (ft)', \
     '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:3 with steps axes x1y2 title 'Flaps', \
     '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:4 with lines axes x1y2 title 'Speedbrake', \
     '/home/stephan/dev/weisair/analysis/xplane_log_b738_enva_enrm.dat' using 1:5 with steps axes x1y2 title 'Landing gear'
