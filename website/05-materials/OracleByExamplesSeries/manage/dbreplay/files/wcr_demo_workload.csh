#!/bin/csh

wcr_demo -u 3000 -t 0.01 -c red & 
wcr_demo -u 3000 -t 0.01 -c green & 
wcr_demo -u 3000 -t 0.01 -c blue & 
wcr_demo -u 3000 -t 0.01 -c black & 
wcr_demo -c yellow -d 10 -t 0.00001 -u 2000 & 
wcr_demo -d 30 -c orange -t 0.00001 -u 2000 &
wcr_demo -d 40 -c salmon -t 0.00001 -u 2000 &
wait
