#!/bin/bash

TARGET=$1
COST=$2
EXIT_CODE=$3

TARGET_FILE=${TARGET}.sh

show_help(){
echo "
$0 target [cost] [exit code]

target		target name
cost		cost time by sec
exit code	exit code to return
"
exit
}

[[ -n $TARGET ]] || show_help
[[ -n $COST ]] || COST=1
[[ -n $EXIT_CODE ]] || EXIT_CODE=0

echo target: $TARGET
echo cost: $COST
echo exit code: $EXIT_CODE


echo "
#!/bin/bash

echo running $TARGET, cost $COST sec
sleep $COST
echo finish $TARGET
exit $EXIT_CODE
" > ${TARGET_FILE}

chmod a+x ${TARGET_FILE}

echo generated to ${TARGET_FILE}
