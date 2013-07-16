#! /bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

# for ap kjører denne jobben på gamle generator
servers="$bt5all"
ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"

for file in /home/mno/strategiske-tjenester/rubrikk/regionene-felles/xtra_jobbdirekte/*.json
do

	fs=`perl -e "print ((stat(\"$file\"))[7]);"`
	if [ -z "$fs" ]; then fs=0; fi

	if [ $fs -gt 200 ]
	then
		for server in $servers
		do
			echo "Kopierer fil $file til $server =>"
			scp -o "ConnectTimeout 10" $file syncdat@$server:$ddir/
		done
	fi
done
