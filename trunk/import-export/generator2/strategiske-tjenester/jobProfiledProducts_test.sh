#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikktest.aftenposten.no/onlineClassifieds/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=4&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O testData/profiledJobsFVN.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O testData/profiledJobsSA.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O testData/profiledJobsBT.json
wget $wopt "$burl?excludeCategoryId=29&utf8=false&siteId=1&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsAP" -O testData/profiledJobsAP.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=4&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O testData/profiledMgmtJobsFVN.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O testData/profiledMgmtJobsSA.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O testData/profiledMgmtJobsBT.json
wget $wopt "$burl?categoryId=29&utf8=false&siteId=1&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsAP" -O testData/profiledMgmtJobsAP.json

wget $wopt "$burl?utf8=true&siteId=2&noOfAds=25&renderType=profiledJobs" -O testData/jobLatestAllBT_flash.json

ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"
ddirai="/export/home/syncdat/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

for server in $fvntest
do
	scpme testData/profiledJobsFVN.json syncdat@$server:$ddir/
	scpme testData/profiledMgmtJobsFVN.json syncdat@$server:$ddir/
done
for server in $satest
do
	scpme testData/profiledJobsSA.json syncdat@$server:$ddir/
	scpme testData/profiledMgmtJobsSA.json syncdat@$server:$ddir/
done
for server in $bttest
do
	scpme testData/profiledJobsBT.json syncdat@$server:$ddir/
	scpme testData/profiledMgmtJobsBT.json syncdat@$server:$ddir/
done
for server in $aitestservers
do
	scpme testData/profiledJobsAP.json syncdat@$server:$ddirai/
	scpme testData/profiledMgmtJobsAP.json syncdat@$server:$ddirai/
done
