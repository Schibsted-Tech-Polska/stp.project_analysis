#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikk.aftenposten.no/onlineClassifieds/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$burl?excludeCategoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledJobs" -O pubData/bt/profiledJobs.json
wget $wopt "$burl?categoryId=29&utf8=true&siteId=2&noOfAds=20&renderType=profiledJobs&cb=cbProfiledMgmtJobs" -O pubData/bt/profiledMgmtJobs.json

ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

scpme pubData/bt/profiledJobs.json syncdat@btpub2.medianorge.no:$ddir/
scpme pubData/bt/profiledMgmtJobs.json syncdat@btpub2.medianorge.no:$ddir/
scpme pubData/bt/profiledJobs.json syncdat@btpub3.medianorge.no:$ddir/
scpme pubData/bt/profiledMgmtJobs.json syncdat@btpub3.medianorge.no:$ddir/

#for server in $btprodny
#do
#	scpme pubData/bt/profiledJobs.json syncdat@$server.medianorge.no:$ddir/
#	scpme pubData/bt/profiledMgmtJobs.json syncdat@$server.medianorge.no:$ddir/
#done
