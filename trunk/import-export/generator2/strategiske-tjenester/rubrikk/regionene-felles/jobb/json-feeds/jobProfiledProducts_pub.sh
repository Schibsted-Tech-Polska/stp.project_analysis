#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikk.aftenposten.no/onlineClassifieds/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$burl?utf8=true&siteId=4&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O pubData/profiledJobsFVN.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O pubData/profiledJobsSA.json
wget $wopt "$burl?excludeCategoryId=29&utf8=false&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsAP" -O pubData/profiledJobsAP.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=4&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O pubData/profiledMgmtJobsFVN.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O pubData/profiledMgmtJobsSA.json
wget $wopt "$burl?categoryId=29&utf8=false&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsAP" -O pubData/profiledMgmtJobsAP.json

wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs" -O pubData/profiledJobsSA_flash.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs" -O pubData/profiledMgmtJobsSA_flash.json

#wget $wopt "$burl?utf8=true&siteId=2&noOfAds=25&renderType=profiledJobs" -O pubData/jobLatestAllBT_flash.json
#wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobsREG" -O pubData/profiledJobsBT.json
#wget $wopt "$burl?categoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobsREG" -O pubData/profiledMgmtJobsBT.json

# for nytt rammeverk - uten region i navn
wget $wopt "$burl?utf8=true&siteId=2&renderType=profiledJobs" -O pubData/bt/profiledJobs_flash.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobs" -O pubData/bt/profiledJobs.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobs" -O pubData/bt/profiledMgmtJobs.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobs" -O pubData/sa/profiledJobs.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobs" -O pubData/sa/profiledMgmtJobs.json
wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs" -O pubData/sa/profiledJobs_flash.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=3&noOfAds=20&renderType=profiledJobs" -O pubData/sa/profiledMgmtJobs_flash.json


ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"
ddirai="/export/home/syncdat/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

for server in $fvnprod
do
	scpme pubData/profiledJobsFVN.json syncdat@$server:$ddir/
	scpme pubData/profiledMgmtJobsFVN.json syncdat@$server:$ddir/
done
for server in $saprod
do
	scpme pubData/profiledJobsSA.json syncdat@$server:$ddir/
	scpme pubData/profiledMgmtJobsSA.json syncdat@$server:$ddir/
	scpme pubData/profiledJobsSA_flash.json syncdat@$server:$ddir/
	scpme pubData/profiledMgmtJobsSA_flash.json syncdat@$server:$ddir/
done
for server in $aiwebpubservers
do
	scpme pubData/profiledJobsAP.json syncdat@$server:$ddirai/
	scpme pubData/profiledMgmtJobsAP.json syncdat@$server:$ddirai/
done
for server in $bt5prod
do
	scpme pubData/bt/profiledJobs.json syncdat@$server:$ddir/
	scpme pubData/bt/profiledMgmtJobs.json syncdat@$server:$ddir/
	scpme pubData/bt/profiledJobs_flash.json syncdat@$server:$ddir/
done
for server in $sa5prod
do
	scpme pubData/sa/profiledJobs.json syncdat@$server:$ddir/
	scpme pubData/sa/profiledMgmtJobs.json syncdat@$server:$ddir/
	scpme pubData/sa/profiledJobs_flash.json syncdat@$server:$ddir/
	scpme pubData/sa/profiledMgmtJobs_flash.json syncdat@$server:$ddir/
done
#for server in $btprod
#do
#	scpme pubData/profiledJobsBT.json syncdat@$server:$ddir/
#	scpme pubData/profiledMgmtJobsBT.json syncdat@$server:$ddir/
#done
