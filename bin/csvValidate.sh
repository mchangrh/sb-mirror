#!/bin/sh

# read number of columns
COLS=$(head -n1 videoInfo.csv | awk 'BEGIN{FS=","}END{print NF}')
echo $COLS
awk -v COLS=$COLS -F, 'NF<COLS' videoInfo.csv > error.csv