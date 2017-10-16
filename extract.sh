#!/bin/sh

RESDIR=$1

gawk 'BEGIN {found=0;} {if (($2 == "Solution") && ($3 == "Found")) {found=1;} if ((found == 1) && (substr($1,1,1) != ";")) {printf("%f: %s\n", $1, substr($0, index($0,":")+1)) }}' $RESDIR/planner.out > $RESDIR/plan
