#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikktest.aftenposten.no/onlineClassifieds"
rurl="$burl/specialCategories.json?renderType=public&noOfJobAds=20&sortJobAdsRandom=true&incAssociatedAds=true"
curl="$burl/categories.json"
lurl="$burl/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$rurl&specialCategoryType=recruitingCompaniesFVN&utf8=true&cb=cbRecruitingCompaniesREG" -O testData/recruitingCompaniesFVN.json
wget $wopt "$rurl&specialCategoryType=recruitingCompaniesSA&utf8=true&cb=cbRecruitingCompaniesREG" -O testData/recruitingCompaniesSA.json
wget $wopt "$rurl&specialCategoryType=recruitingCompaniesBT&utf8=true&cb=cbRecruitingCompaniesREG" -O testData/recruitingCompaniesBT.json
wget $wopt "$rurl&specialCategoryType=recruitingCompanies&utf8=false&cb=cbRecruitingCompaniesAP" -O testData/recruitingCompaniesAP.json
wget $wopt "$curl?utf8=true&siteId=4&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O testData/jobCategoriesFVN.json
wget $wopt "$curl?utf8=true&siteId=3&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O testData/jobCategoriesSA.json
wget $wopt "$curl?utf8=true&siteId=2&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O testData/jobCategoriesBT.json
wget $wopt "$curl?utf8=false&siteId=1&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesAP" -O testData/jobCategoriesAP.json
wget $wopt "$lurl?utf8=true&siteId=4&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O testData/jobLatestAllFVN.json
wget $wopt "$lurl?utf8=true&siteId=3&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O testData/jobLatestAllSA.json
wget $wopt "$lurl?utf8=true&siteId=2&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O testData/jobLatestAllBT.json
wget $wopt "$lurl?utf8=false&siteId=1&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O testData/jobLatestAllAP.json

ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"
ddirai="/export/home/syncdat/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

for server in $fvntest
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme testData/recruitingCompaniesFVN.json syncdat@$server:$ddir/
	scpme testData/jobCategoriesFVN.json syncdat@$server:$ddir/
        scpme testData/jobLatestAllFVN.json syncdat@$server:$ddir/
done
for server in $satest
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme testData/recruitingCompaniesSA.json syncdat@$server:$ddir/
	scpme testData/jobCategoriesSA.json syncdat@$server:$ddir/
        scpme testData/jobLatestAllSA.json syncdat@$server:$ddir/
done
for server in $bttest
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme testData/recruitingCompaniesBT.json syncdat@$server:$ddir/
	scpme testData/jobCategoriesBT.json syncdat@$server:$ddir/
        scpme testData/jobLatestAllBT.json syncdat@$server:$ddir/
	scpme testData/jobLatestAllBT_flash.json syncdat@$server:$ddir/
done
for server in $aitestservers
do
	#ssh syncdat@$server "mkdir -p $ddirai"
	scpme testData/recruitingCompaniesAP.json syncdat@$server:$ddirai/
	scpme testData/jobCategoriesAP.json syncdat@$server:$ddirai/
        scpme testData/jobLatestAllAP.json syncdat@$server:$ddir/
done
