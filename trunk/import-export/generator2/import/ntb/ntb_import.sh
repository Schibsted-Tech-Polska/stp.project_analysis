#!/bin/sh
# Hent NTB

odir=`pwd`
cd `dirname $0`
mydir=`pwd`

logdir="$mydir/log"
archivedir="$mydir/data/ntb/archive"

{
echo "NTB nedlasting startet: `date`"
stime="`date +%s`"

./ntb_import_get.pl
./ntb_send.pl

etime="`date +%s`"
utime="`echo $etime - $stime | bc | awk '{print $1}'`"

echo "NTB nedlasting ferdig: `date`"
echo "Tid brukt: $utime"

# Kjør skript som klargjør import
#wget --output-document=/data/import/ntb/ntbimport.log --tries=1 --timeout=40 http://fvnpub.medianorge.no/admin/ntb/ntbImport.jsp
} >>$logdir/ntb_import-`date +%Y-%m-%d.log` 2>&1

find $logdir -type f -name "ntb_import-*" -mtime +30 -delete >/dev/null 2>&1
find $archivedir -type f -mtime +30 -delete >/dev/null 2>&1
