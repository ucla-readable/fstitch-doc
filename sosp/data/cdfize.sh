#!/bin/bash

if [ $# -gt 0 ]
then
	for FILE in "$@"
	do
		cat "$FILE" | "$0"
	done
	exit
fi

TOTAL=0
while read LINE
do
	if [ -z "$LINE" ]
	then
		TOTAL=0
		echo
	elif [ "${LINE###}" == "$LINE" ]
	then
		INDEX="`echo "$LINE" | awk '{ print $1 }'`"
		VALUE="`echo "$LINE" | awk '{ print $2 }'`"
		TOTAL=$(($TOTAL + $VALUE))
		echo "$INDEX $TOTAL"
	else
		echo "$LINE"
	fi
done
