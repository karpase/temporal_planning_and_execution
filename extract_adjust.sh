#!/bin/sh

RESDIR=$1
ADJUSTMENT=$2

gawk --assign=ta=$ADJUSTMENT 'BEGIN {found=0;} {if (($2 == "Solution") && ($3 == "Found")) {found=1;} if ((found == 1) && (substr($1,1,1) != ";")) {printf("%f: %s\n", $1+ta, substr($0, index($0,":")+1)) }}' $RESDIR/planner.out > $RESDIR/adjusted_plan 
