#!/bin/sh
# Parameters: <domain> <problem> <domain_name> 
# Runs the smart approach and the baseline approach with 1, 10, 100, and 1000

if [ $# -lt 3 ] 
  then
    echo "Usage: run_problem.sh <domain> <problem> <domain_name>"
    exit
fi


SMART=`./smart.sh $1 $2 $3`
B1=`./baseline.sh $1 $2 $3 1`
B10=`./baseline.sh $1 $2 $3 10`
B100=`./baseline.sh $1 $2 $3 100`
B1000=`./baseline.sh $1 $2 $3 1000`

probname=`basename $2`

echo $3, $probname, $SMART, $B1, $B10, $B100, $B1000


