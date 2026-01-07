#!/usr/bin/bash

output="test1.png"
data=statistics_to_plot.csv
gnuplot -e "datafile='${data}'; outputname='${output}'" plot_param_test
