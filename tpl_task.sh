target_TPL_TARGET(){
	flow_id=$1
	target='TPL_TARGET'
	dep='TPL_DEP'
	cmd='TPL_CMD'

	wait_dep $flow_id $target
	dep_ret=$?
	echo target_TPL_TARGET: dep_ret: $dep_ret
	if [[ $dep_ret = "0" ]]; then
		echo target_TPL_TARGET: go to run cmd: $cmd
		$cmd
		ret=$?
	else
		echo target_TPL_TARGET: dependent target rerturn non-zero, do nothing and exit
		ret=$dep_ret
	fi
	write_ret_val $flow_id $target $ret
	echo target_TPL_TARGET: exit with code $ret
	exit $ret
}

