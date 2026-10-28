set terminal pngcairo size 1600,900
set output '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261026_1045_B738_EDDC_EDDF/data/20261026_1045_B738_EDDC_EDDF.png'
set title '20261026_1045_B738_EDDC_EDDF' noenhanced
set xlabel "Zulu time"
set ylabel "Altitude (ft)"
set y2label "Speed (kts)"
set ytics nomirror
set y2tics autofreq
set bmargin at screen 0.428
set grid
set key outside right center
set xrange [47744.052:51626.678]
set xtics ('13:15:44Z' 47744.052, '13:30Z' 48600.000, '13:40Z' 49200.000, '13:50Z' 49800.000, '14:00Z' 50400.000, '14:10Z' 51000.000, '14:20:27Z' 51626.678)
set arrow 1 from graph 0, screen 0.212 to graph 1, screen 0.212 nohead front lc rgb '#888888' lw 0.7
set arrow 2 from graph 0, screen 0.318 to graph 1, screen 0.318 nohead front lc rgb '#888888' lw 0.7
set arrow 3 from graph 0, screen 0.212 to graph 0, screen 0.318 nohead front lc rgb '#888888' lw 0.7
set arrow 4 from graph 1, screen 0.212 to graph 1, screen 0.318 nohead front lc rgb '#888888' lw 0.7
set arrow 5 from graph 0, screen 0.131 to graph 1, screen 0.131 nohead front lc rgb '#888888' lw 0.7
set arrow 6 from graph 0, screen 0.202 to graph 1, screen 0.202 nohead front lc rgb '#888888' lw 0.7
set arrow 7 from graph 0, screen 0.131 to graph 0, screen 0.202 nohead front lc rgb '#888888' lw 0.7
set arrow 8 from graph 1, screen 0.131 to graph 1, screen 0.202 nohead front lc rgb '#888888' lw 0.7
set arrow 9 from graph 0, screen 0.050 to graph 1, screen 0.050 nohead front lc rgb '#888888' lw 0.7
set arrow 10 from graph 0, screen 0.121 to graph 1, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 11 from graph 0, screen 0.050 to graph 0, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 12 from graph 1, screen 0.050 to graph 1, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 13 from first 48150.659, graph 0 to first 48150.659, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 14 from first 48279.124, graph 0 to first 48279.124, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 15 from first 48311.183, graph 0 to first 48311.183, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 16 from first 48352.224, graph 0 to first 48352.224, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 17 from first 49230.196, graph 0 to first 49230.196, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 18 from first 49344.828, graph 0 to first 49344.828, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 19 from first 50869.219, graph 0 to first 50869.219, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 20 from first 50905.357, graph 0 to first 50905.357, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 21 from first 51201.271, graph 0 to first 51201.271, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 22 from first 51241.185, graph 0 to first 51241.185, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 23 from first 51345.212, graph 0 to first 51345.212, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 24 from first 51576.021, graph 0 to first 51576.021, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set label 1 'FLAPS' at screen 0.035, screen 0.265 center rotate by 90
set label 2 '50%' at first 48150.659, screen 0.282 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 3 '25%' at first 48311.183, screen 0.282 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 4 '0%' at first 48352.224, screen 0.247 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 5 '25%' at first 50905.357, screen 0.282 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 6 '50%' at first 51201.271, screen 0.282 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 7 '75%' at first 51241.185, screen 0.247 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 8 '100%' at first 51345.212, screen 0.282 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 9 'GEAR' at screen 0.035, screen 0.166 center rotate by 90
set label 10 '0%' at first 48279.124, screen 0.166 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 11 '100%' at first 50869.219, screen 0.166 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 12 'SPDBRK' at screen 0.035, screen 0.085 center rotate by 90
set label 13 '47%' at first 49230.196, screen 0.085 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 14 '0%' at first 49344.828, screen 0.085 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 15 '87%' at first 51576.021, screen 0.085 left point pt 11 ps 1.1 offset 0.35,-0.25
plot '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261026_1045_B738_EDDC_EDDF/data/20261026_1045_B738_EDDC_EDDF.dat' using 1:2 with lines title 'Altitude (ft)', \
     '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261026_1045_B738_EDDC_EDDF/data/20261026_1045_B738_EDDC_EDDF.dat' using 1:3 with lines axes x1y2 title 'Indicated airspeed (kts)'
set terminal canvas size 1600,900 standalone mousing
set output '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261026_1045_B738_EDDC_EDDF/data/20261026_1045_B738_EDDC_EDDF.html'
replot
set output
