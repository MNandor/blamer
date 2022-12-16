#!/bin/bash

commits=`git log --oneline $@ | sed 's/ .*//'`

sel=0
diff=''

while true; do
	clear

	cur=0
	for commit in $commits; do
		if [ $cur == $sel ]; then
			echo -n '*'
		fi
		echo -n "$commit "
		cur=$(($cur + 1))
	done

	commt=`echo $commits | sed 's/[a-z]/\u\0/' | cut -d' ' -f $((sel + 1))`
	commtc=`echo $commits | wc -w`
	echo $commtc


	echo

	if [ -z "$diff" ]; then
		git show $commt $@
	elif [ "$diff" == ':' ]; then
		git show $commt:$@
	fi

	echo -e "\n$diff$commt - h/l to switch commit, d to toggle diff, q to quit"
	read -n 1 -s key
	if [ $key == 'l' ] && (( $sel < $commtc - 1 )); then
		sel=$(($sel + 1))
	fi
	if [ $key == 'h' ] && [ "$sel" -gt 0 ]; then
		sel=$(($sel - 1))
	fi
	if [ $key == 'd' ]; then
		if [ -z "$diff" ]; then
			diff=':'
			echo hiiii
		elif [ "$diff" == ':' ]; then
			diff=''
		fi
	fi
	if [ $key == 'q' ]; then
		break
	fi

done

