#!/bin/bash

cd `dirname $0`
. /usr/local/etc/mno/include.sh

burl="http://rubrikk.aftenposten.no/onlineClassifieds"
rurl="$burl/specialCategories.json?renderType=public&noOfJobAds=20&sortJobAdsRandom=true&incAssociatedAds=true"
curl="$burl/categories.json"
lurl="$burl/jobads.json"
wopt="-t 1 --timeout=20"

wget $wopt "$rurl&specialCategoryType=recruitingCompaniesFVN&utf8=true&cb=cbRecruitingCompaniesREG" -O pubData/recruitingCompaniesFVN.json
wget $wopt "$rurl&specialCategoryType=recruitingCompaniesSA&utf8=true&cb=cbRecruitingCompaniesREG" -O pubData/recruitingCompaniesSA.json
wget $wopt "$rurl&specialCategoryType=recruitingCompaniesBT&utf8=true&cb=cbRecruitingCompaniesREG" -O pubData/recruitingCompaniesBT.json
wget $wopt "$rurl&specialCategoryType=recruitingCompanies&utf8=false&cb=cbRecruitingCompaniesAP" -O pubData/recruitingCompaniesAP.json
wget $wopt "$curl?utf8=true&siteId=4&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O pubData/jobCategoriesFVN.json
wget $wopt "$curl?utf8=true&siteId=3&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O pubData/jobCategoriesSA.json
wget $wopt "$curl?utf8=true&siteId=2&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesREG" -O pubData/jobCategoriesBT.json
wget $wopt "$curl?utf8=false&siteId=1&adCountType=job&renderType=public&node=27&cb=cbJobCategoriesAP" -O pubData/jobCategoriesAP.json
wget $wopt "$lurl?utf8=true&siteId=4&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O pubData/jobLatestAllFVN.json
wget $wopt "$lurl?utf8=true&siteId=3&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O pubData/jobLatestAllSA.json
wget $wopt "$lurl?utf8=true&siteId=3&renderType=latestJobs&noOfAds=10" -O pubData/jobLatestAllSA_flash.json
wget $wopt "$lurl?utf8=true&siteId=2&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O pubData/jobLatestAllBT.json
wget $wopt "$lurl?utf8=false&siteId=1&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAllREG" -O pubData/jobLatestAllAP.json

# for nytt rammeverk - uten region i navn
wget $wopt "$rurl&specialCategoryType=recruitingCompaniesBT&utf8=true&cb=cbRecruitingCompanies" -O pubData/bt/recruitingCompanies.json
wget $wopt "$curl?utf8=true&siteId=2&adCountType=job&renderType=public&node=27&cb=cbJobCategories" -O pubData/bt/jobCategories.json
wget $wopt "$lurl?utf8=true&siteId=2&renderType=latestJobs&noOfAds=10&cb=cbLatestJobsListAll" -O pubData/bt/jobLatestAll.json


ddir="/home/syncdat/data/rubrikk/jobb/json-feeds"
ddirai="/export/home/syncdat/rubrikk/jobb/json-feeds"

scpme() {
	# $1: src $2: dst
	scp -o "ConnectTimeout 10" $1 $2
}

for server in $fvnprod
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme pubData/recruitingCompaniesFVN.json syncdat@$server:$ddir/
	scpme pubData/jobCategoriesFVN.json syncdat@$server:$ddir/
	scpme pubData/jobLatestAllFVN.json syncdat@$server:$ddir/
done
for server in $saprod
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme pubData/recruitingCompaniesSA.json syncdat@$server:$ddir/
	scpme pubData/jobCategoriesSA.json syncdat@$server:$ddir/
	scpme pubData/jobLatestAllSA.json syncdat@$server:$ddir/
	scpme pubData/jobLatestAllSA_flash.json syncdat@$server:$ddir/
done
for server in $btprod
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme pubData/recruitingCompaniesBT.json syncdat@$server:$ddir/
	scpme pubData/jobCategoriesBT.json syncdat@$server:$ddir/
	scpme pubData/jobLatestAllBT.json syncdat@$server:$ddir/
	scpme pubData/jobLatestAllBT_flash.json syncdat@$server:$ddir/
done
for server in $aiwebpubservers
do
	#ssh syncdat@$server "mkdir -p $ddirai"
	scpme pubData/recruitingCompaniesAP.json syncdat@$server:$ddirai/
	scpme pubData/jobCategoriesAP.json syncdat@$server:$ddirai/
	scpme pubData/jobLatestAllAP.json syncdat@$server:$ddir/
done
for server in $bt5prod
do
	#ssh syncdat@$server "mkdir -p $ddir"
	scpme pubData/bt/recruitingCompanies.json syncdat@$server:$ddir/
	scpme pubData/bt/jobCategories.json syncdat@$server:$ddir/
	scpme pubData/bt/jobLatestAll.json syncdat@$server:$ddir/
done
