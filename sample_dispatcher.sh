#!/bin/bash

wait_dep(){
	echo -n $1 wait for dep targets:
	shift 
	echo $*

	for target_pid in $*
	do
		wait $target_pid
	done
}

targetA(){
	echo targetA
	wait_dep targetA $*
	./commandA.sh
}

targetB(){
	echo targetB
	wait_dep targetB $*
	./commandB.sh
}

targetC(){
	echo targetC
	wait_dep targetC $*
	./commandC.sh
}

targetD(){
	echo targetD
	wait_dep targetD $*
	./commandD.sh
}


targetC &
PID_C=$!
echo PID_C: $PID_C

targetD &
PID_D=$!
echo PID_D: $PID_D

targetB $PID_D &
PID_B=$!
echo PID_B: $PID_B

targetA $PID_B $PID_C &
PID_A=$!
echo PID_A: $PID_A

wait
echo finish all
