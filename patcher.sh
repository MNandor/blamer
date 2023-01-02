#!/bin/bash

patches=`ls patches`

for patch in $patches; do
	echo $patch
	git apply --check --reverse patches/$patch 2>/dev/null && echo Removable
	git apply --check patches/$patch 2>/dev/null && echo Appliable

done

