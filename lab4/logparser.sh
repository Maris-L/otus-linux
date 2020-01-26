#!/bin/bash
# config section
lockfile=lockfile.lock #nginx log parser lockfile
X="10" # count of records X - IP address 
Y="10" # count of requests
address="vagrant@localhost" #address for email
mailsubj="nginx top requests" #email subject
logfile=access-4560-644067.log #nginx logfile
outputfile=result #nginx results file
# trap section
if [ -f $lockfile ]
then
  echo "Lockfile"
  exit 1 
else
  echo "PID: $$" > $lockfile
  trap 'rm -f $lockfile"; exit $?' INT TERM EXIT
fi
# log parsing section
set X, env X
set Y, env Y
echo "IP addresses" >> $outputfile
cat $logfile | awk '{print $'${3-1}'}' | sort -n | uniq -c | sort -rn | head -n$X | awk '{print $2,$1}' >> $outputfile
echo "Most requests" >> $outputfile
cat $logfile | awk '{print $7}' | sort | uniq -c | sort -rn | tail -$Y >> $outputfile
echo "Total errors" >> $outputfile
cat $logfile | awk '{print $9}' | grep -E "[4-5]{1}[0-9][0-9]" | sort | uniq -c | sort -rn >> $outputfile
echo "Return codes" >> $outputfile
cat $logfile | awk '{print $9}' | sort | uniq -c | sort -rn >> $outputfile
# mail section
stime=`date '+%Y_%m_%d__%H_%M_%S'`
cp $outputfile result_$stime
mail -a result_$stime -s $mailsubj $address < /dev/null
rm -f $outputfile
# trap section
rm -f $lockfile
  trap - INT TERM EXIT
exit 0
