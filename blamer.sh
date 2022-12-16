#!/bin/bash

commits=`git log --oneline $@ | sed 's/ .*//'`

sel=0

while true; do
	cur=0
	for commit in $commits; do
		if [ $cur == $sel ]; then
			echo -n '*'
		fi
		echo -n "$commit "
		cur=$(($cur + 1))
	done

	commt=`echo $commits | sed 's/[a-z]/\u\0/' | cut -d' ' -f $((sel + 1))`

	git show $commt $@

	echo -e "\n$commt - h/l to switch commit"
	read -n 1 -s key
	if [ $key == 'l' ]; then
		sel=$(($sel + 1))
	fi
	if [ $key == 'h' ]; then
		sel=$(($sel - 1))
	fi

done

