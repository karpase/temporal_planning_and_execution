#!/bin/sh
# Parameters: <domain> <problem> 
# Implements the smart approach


PLANNER="/home/karpase/planners/temporal/optic+/release/optic+no-lp"
VAL=/home/karpase/planners/temporal/descarwin/doc/papers/ijcai2013/expes-LPG/bin/validate

if [ $# -lt 2 ] 
  then
    echo "Usage: baseline.sh <domain> <problem> <til_adjustment>"
    exit
fi

mkdir -p tmp
CPATH=`pwd`

# Adjust PDDL problem
python3 adjust_til.py $1 $2 $3 tmp/newprob.pddl

# Call Planner
$PLANNER $1 tmp/newprob.pddl > tmp/planner.out

# Extract solution and adjust it
gawk 'BEGIN {found=0;} {if (($2 == "Solution") && ($3 == "Found")) {found=1;} if ((found == 1) && (substr($1,1,1) != ";")) {printf("%f: %s\n", $1, substr($0, index($0,":")+1)) }}' tmp/planner.out > tmp/adjusted_plan

# Validate adjuest solution against original problem
$VAL -v $1 $2 tmp/adjusted_plan
