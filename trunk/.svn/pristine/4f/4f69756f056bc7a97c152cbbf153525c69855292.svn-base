#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikk.aftenposten.no/onlineClassifieds/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobs" -O testData/bt/profiledJobs.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobs" -O testData/bt/profiledMgmtJobs.json
wget $wopt "$burl?utf8=true&siteId=2&noOfAds=25&renderType=profiledJobs" -O testData/bt/jobLatestAll_flash.json

ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

scpme testData/bt/profiledJobs.json syncdat@bttest2.medianorge.no:$ddir/
scpme testData/bt/profiledMgmtJobs.json syncdat@bttest2.medianorge.no:$ddir/
scpme testData/bt/jobLatestAll_flash.json syncdat@bttest2.medianorge.no:$ddir/
