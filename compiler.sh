#!/bin/bash

dispatcher=dispatcher.sh
dispatch_dir=".dispather"
single_target_dir=$dispatch_dir/single_targets
entries_dir=$dispatch_dir/entries
flows_dir=$dispatch_dir/flows


clear_tmp_files(){
	rm -rvf $dispatch_dir
	rm -rvf $dispatcher
}

init_env(){
	mkdir -p $single_target_dir
	mkdir -p $flows_dir
	mkdir -p $entries_dir
	
}

gen_single_targets(){
	i=0
	cat tasks.def | while read ln;
	do
		echo $ln | sed 's|^target\s*\(\S*\)(\(.*\))\s*\(.*$\)|target=\"\1\"\ndep=\"\2\"\ncmd=\"\3\"\n|g' > $single_target_dir/$i.target
		i=$((i+1)); 
	done
}

gen_dispatcher(){
	targets=$(ls $single_target_dir)
	for t in $targets
	do
		. $single_target_dir/$t

		if [[ -z $dep ]]; then
			echo create entry $target
			echo "target_$target" > $entries_dir/$target.entry
		fi

		echo work on target: $target
		echo "target_$target(){
	$cmd	
}

" >> $dispatcher
	done
}

clear_tmp_files
init_env
gen_single_targets
gen_dispatcher

exit 0
