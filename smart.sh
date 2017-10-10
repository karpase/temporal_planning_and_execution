#!/bin/sh
# Parameters: <domain> <problem> 
# Implements the smart approach: calls the time-aware planner, and validates the result
# Returns 0 if this works, non-zero otherwise

PLANNER="/home/karpase/planners/temporal/optic+/release/optic+no-lp"
VAL=/home/karpase/planners/temporal/descarwin/doc/papers/ijcai2013/expes-LPG/bin/validate

if [ $# -lt 3 ] 
  then
    echo "Usage: baseline.sh <domain> <problem> <domain_name>"
    exit
fi

probname=`basename $2`


RESDIR=results/$3/$probname/smart
mkdir -p $RESDIR


# Call Planner
$PLANNER $1 $2 > $RESDIR/planner.out 

# Extract solution and adjust it
gawk 'BEGIN {found=0;} {if (($2 == "Solution") && ($3 == "Found")) {found=1;} if ((found == 1) && (substr($1,1,1) != ";")) {printf("%f: %s\n", $1, substr($0, index($0,":")+1)) }}' $RESDIR/planner.out > $RESDIR/plan

# Validate adjuest solution against original problem
$VAL -t 0.001 $1 $2 $RESDIR/plan > $RESDIR/val.log

echo $?
