#!/bin/sh
# Parameters: <domain> <problem> <domain_name> <til_adjustment>
# Implements the baseline approach: takes as input a PDDL domain and file, and
# 1. Adjusts the timestamps of the TILs by til_adjustment
# 2. Calls a planner on the new problem
# 3. Adjusts the timestamps on the resultsing plan
# 4. Calls VAL to check the new plan
# Returns 0 if this works, non-zero otherwise


PLANNER="/home/karpase/planners/temporal/optic+/release/optic+no-lp --real-to-plan-time-multiplier 0"
VAL=/home/karpase/planners/temporal/descarwin/doc/papers/ijcai2013/expes-LPG/bin/validate

if [ $# -lt 4 ] 
  then
    echo "Usage: baseline.sh <domain> <problem> <domain_name> <til_adjustment>"
    exit
fi

probname=`basename $2`

RESDIR=results/$3/$probname/baseline/$4
mkdir -p $RESDIR

# Adjust PDDL problem
python3 adjust_til.py $1 $2 $4 $RESDIR/newprob.pddl > $RESDIR/adjust.out

# Call Planner
$PLANNER $1 $RESDIR/newprob.pddl > $RESDIR/planner.out 

# Extract solution and adjust it
gawk --assign=ta=$4 'BEGIN {found=0;} {if (($2 == "Solution") && ($3 == "Found")) {found=1;} if ((found == 1) && (substr($1,1,1) != ";")) {printf("%f: %s\n", $1+ta, substr($0, index($0,":")+1)) }}' $RESDIR/planner.out > $RESDIR/adjusted_plan 

# Validate adjuest solution against original problem
$VAL -t 0.001 $1 $2 $RESDIR/adjusted_plan > $RESDIR/val.log

echo $?
