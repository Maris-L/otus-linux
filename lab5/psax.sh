#!/bin/bash

cd /proc
clockspersec=$(getconf CLK_TCK)

for pid in $(ls -l | awk '{print $9}' | grep -E '[[:digit:]]' | sort -n);
do 
	tty=$(cat 2>/dev/null $pid/stat | awk '{printf $7}')
	state=$(cat 2>/dev/null $pid/stat | awk '{print $3}')
	nice=$(cat 2>/dev/null $pid/stat | awk  '{print $19}')
	threads=$(cat 2>/dev/null $pid/stat | awk  '{print $20}') 
	utime=$(cat 2>/dev/null $pid/stat | awk '{print $14}')
	stime=$(cat  2>/dev/null $pid/stat | awk '{print $17}')
	command=$(cat 2>/dev/null $pid/cmdline | awk '{printf "%10s", $0}')

time=$((utime+stime))
pstime=$((time/clockspersec))

printf "$pid | $tty | $state | $nice | $threads | $pstime | $command"
echo -e '\r'
done
