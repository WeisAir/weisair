set terminal pngcairo size 1600,900
set output '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261018_2340_BE58_KSFO_KSFO/data/20261018_2340_BE58_KSFO_KSFO.png'
set title '20261018_2340_BE58_KSFO_KSFO' noenhanced
set xlabel "Zulu time"
set ylabel "Altitude (ft)"
set y2label "Speed (kts)"
set ytics nomirror
set y2tics autofreq
set bmargin at screen 0.417
set grid
set key outside right center
set xrange [63720.408:64180.138]
set xtics ('17:42:00Z' 63720.408, '17:49:40Z' 64180.138)
set arrow 1 from graph 0, screen 0.131 to graph 1, screen 0.131 nohead front lc rgb '#888888' lw 0.7
set arrow 2 from graph 0, screen 0.307 to graph 1, screen 0.307 nohead front lc rgb '#888888' lw 0.7
set arrow 3 from graph 0, screen 0.131 to graph 0, screen 0.307 nohead front lc rgb '#888888' lw 0.7
set arrow 4 from graph 1, screen 0.131 to graph 1, screen 0.307 nohead front lc rgb '#888888' lw 0.7
set arrow 5 from graph 0, screen 0.050 to graph 1, screen 0.050 nohead front lc rgb '#888888' lw 0.7
set arrow 6 from graph 0, screen 0.121 to graph 1, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 7 from graph 0, screen 0.050 to graph 0, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 8 from graph 1, screen 0.050 to graph 1, screen 0.121 nohead front lc rgb '#888888' lw 0.7
set arrow 9 from first 63729.218, graph 0 to first 63729.218, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 10 from first 63730.021, graph 0 to first 63730.021, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 11 from first 63778.841, graph 0 to first 63778.841, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 12 from first 63786.044, graph 0 to first 63786.044, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 13 from first 63787.644, graph 0 to first 63787.644, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 14 from first 64052.888, graph 0 to first 64052.888, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 15 from first 64056.892, graph 0 to first 64056.892, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 16 from first 64058.492, graph 0 to first 64058.492, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 17 from first 64059.295, graph 0 to first 64059.295, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set arrow 18 from first 64060.091, graph 0 to first 64060.091, screen 0.050 nohead dt 2 lw 0.5 lc rgb '#888888' back
set label 1 'FLAPS' at screen 0.035, screen 0.219 center rotate by 90
set label 2 '25%' at first 63729.218, screen 0.271 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 3 '50%' at first 63730.021, screen 0.236 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 4 '25%' at first 63786.044, screen 0.271 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 5 '0%' at first 63787.644, screen 0.236 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 6 '25%' at first 64056.892, screen 0.271 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 7 '50%' at first 64058.492, screen 0.236 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 8 '75%' at first 64059.295, screen 0.201 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 9 '100%' at first 64060.091, screen 0.166 left point pt 11 ps 1.1 offset 0.35,-0.25
set label 10 'GEAR' at screen 0.035, screen 0.085 center rotate by 90
set label 11 '0%' at first 63778.841, screen 0.085 left point pt 9 ps 1.1 offset 0.35,-0.25
set label 12 '100%' at first 64052.888, screen 0.085 left point pt 11 ps 1.1 offset 0.35,-0.25
plot '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261018_2340_BE58_KSFO_KSFO/data/20261018_2340_BE58_KSFO_KSFO.dat' using 1:2 with lines title 'Altitude (ft)'
set terminal canvas size 1600,900 standalone mousing
set output '/home/stephan/dev/weisair/batch_scripts/LinuxXPDebrief/flights/20261018_2340_BE58_KSFO_KSFO/data/20261018_2340_BE58_KSFO_KSFO.html'
replot
set output
