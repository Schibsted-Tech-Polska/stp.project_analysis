#! /bin/sh

cd `dirname $0`
odir=`pwd`

logdir="$odir/logs"

{
echo "================================================================================"
echo "XMLSync-export-fast STARTET: `date`"
./xmlsync-export-fast.pl
echo "Post-processing: `date`"
./ece_fast_post_del_bt.pl
./ece_fast_post_del_sa.pl
./ece_fast_post_del_bilvertikal.pl
echo "XMLSync-export-fast FERDIG: `date`"
} >>$logdir/xmlsync-export-fast-`date +%Y-%m-%d`.log 2>&1

#Erase old logs
find $logdir -mtime +30 -type f -name "xmlsync-export-fast-*.log*" -delete >/dev/null 2>&1
#Compress
find $logdir -mmin +1440 -type f -name "xmlsync-export-fast-*.log" \! -name "*.gz" | xargs gzip -9 >/dev/null 2>&1
