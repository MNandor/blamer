#!/bin/bash

patches=`ls patches`

for patch in $patches; do
	(git apply --check --reverse patches/$patch 2>/dev/null && echo -e "\033[1;32m$patch\033[0m") ||
	(git apply --check patches/$patch 2>/dev/null && echo -e "\033[1;33m$patch\033[0m") ||
	echo -e "\033[1;31m$patch\033[0m"

done
	echo -e "\n\033[1;32mApplied\033[0m" "\033[1;33mAppliable\033[0m" "\033[1;31mBad\033[0m"

