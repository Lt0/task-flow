write_ret_val(){
	flow_id=$1
	target=$2
	ret=$3

	be_dep=$(ls /tmp/flow_${flow_id}_*_wait_${target} 2>/dev/null)

	echo write_ret_val: be_dep: $be_dep

	for bd in $be_dep
	do
		echo write_ret_val: write $ret to $bd
		echo $ret > $bd &
	done

	# report to flow
	echo $target write $ret to $be_dep > /tmp/flow_${flow_id} &
	echo $target finish > /tmp/flow_${flow_id} &
	echo write_ret_val: write finish
}

# test
#write_ret_val 11 D 1

wait_dep(){
	flow_id=$1
	target=$2
	all_ret=0

	fifos=$(ls /tmp/flow_${flow_id}_${target}_wait_* 2>/dev/null)

	echo wait_dep: $target wait fifos: $fifos
        for f in $fifos
        do
		echo wait_dep: $target block in waiting $f
                ret=$(cat $f)
		echo wait_dep: $target wait from $f found $ret
                if [[ $ret != "0" ]]; then
			all_ret=$ret
                fi
        done

	return $all_ret

}

#wait_dep 11 A &
#write_ret_val 11 D 0

clear_fifos(){
	echo clear fifos
	for f in $fifos
	do
	        rm -rf $f
	done
}

mk_fifos(){
	echo make fifos
	for f in $fifos
	do
	        mkfifo $f
	done
}


