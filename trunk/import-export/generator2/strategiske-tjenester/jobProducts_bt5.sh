#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikk.aftenposten.no/onlineClassifieds"
rurl="$burl/specialCategories.json?renderType=public&noOfJobAds=20&sortJobAdsRandom=true&incAssociatedAds=true"
curl="$burl/categories.json"
lurl="$burl/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$rurl&specialCategoryType=recruitingCompaniesBT&utf8=true&cb=cbRecruitingCompanies" -O pubData/bt/recruitingCompanies.json
wget $wopt "$curl?utf8=true&siteId=2&adCountType=job&renderType=public&node=27&cb=cbJobCategories" -O pubData/bt/jobCategories.json
wget $wopt "$lurl?utf8=true&siteId=2&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAll" -O pubData/bt/jobLatestAll.json

ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

#ssh syncdat@btpub2.medianorge.no "mkdir -p $ddir"

scpme pubData/bt/recruitingCompanies.json syncdat@btpub2:$ddir/
scpme pubData/bt/jobCategories.json syncdat@btpub2:$ddir/
scpme pubData/bt/jobLatestAll.json syncdat@btpub2:$ddir/

scpme pubData/bt/recruitingCompanies.json syncdat@btpub3:$ddir/
scpme pubData/bt/jobCategories.json syncdat@btpub3:$ddir/
scpme pubData/bt/jobLatestAll.json syncdat@btpub3:$ddir/


#for server in $bt5prod
#do
	#ssh syncdat@$server "mkdir -p $ddir"
#	scpme pubData/bt/recruitingCompanies.json syncdat@$server:$ddir/
#	scpme pubData/bt/jobCategories.json syncdat@$server:$ddir/
#	scpme pubData/bt/jobLatestAll.json syncdat@$server:$ddir/
#done