#!/bin/bash

let nbthreadmax=$1
let cpumax=$2

$(./code 5; echo $? > res) & pid=$!;
while kill -0 $pid
do
	if [[ $(pgrep -P $pid | wc -l | bc) -gt $nbthreadmax ]]
	then
		echo "trop de process"
	fi

	if [[ $(ps -p $pid -o %cpu | sed -n 2p | sed -s 's/^.//' | cut -d '.' -f1 | bc) -gt $cpumax ]]
	then
		echo "$pid trop gros";
	fi

	for child in $(pgrep -P $pid);
	do
		if [[ $(ps -p $child -o %cpu | sed -n 2p | sed -s 's/^.//' | cut -d '.' -f1 | bc) -gt $cpumax ]]
		then
			echo "$child trop gros";
		fi
	done
	sleep 0.3;
done
cat res;

