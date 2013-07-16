#! /bin/sh

cd `dirname $0`
odir=`pwd`

logdir="$odir/logs"

{
echo "================================================================================"
echo "XMLSync-exportimport STARTET: `date`"
./xmlsync-exportimport.pl
./CARMIGR_xmlsync-exportimport_TMP.pl
echo "XMLSync-exportimport FERDIG: `date`"
} >>$logdir/xmlsync-exportimport-`date +%Y-%m-%d`.log 2>&1

#Erase old logs
find $logdir -mtime +30 -type f -name "xmlsync-exportimport-*.log" -delete >/dev/null 2>&1
#Compress
find $logdir -mmin +1440 -type f -name "xmlsync-exportimport-*.log" \! -name "*.gz" | xargs gzip -9 >/dev/null 2>&1
