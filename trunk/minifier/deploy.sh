#!/bin/bash
if [ "$1" = "" ]
then
  echo "Usage:"
  echo "$0 ap5|sa5|bt5|fvn5|mnovertikal|mnosprek dev|test|pub1|pub2"
  exit
fi

mode="$1"
host="$2"

if [ "${mode}" != "" ]
then
    case $1 in
    ap5)
        PUBLICATIONS=ap
        sources=mnofr
        warname=ap
        webdir=/data/webapps/ap/ap
        test_host=aptest2.medianorge.no
        pub1_host=appub1.medianorge.no
        pub2_host=appub2.medianorge.no
    ;;
    bt5)
        PUBLICATIONS=bt
        sources=mnofr
        warname=bt
        webdir=/data/webapps/bt/bt
    ;;
    sa5)
        PUBLICATIONS=sa
        sources=mnofr
        warname=sa
        webdir=/data/webapps/sa/sa
    ;;
    fvn5)
        PUBLICATIONS=fvn
        sources=mnofr
        warname=fvn
        webdir=/data/webapps/fvn/fvn
    ;;
    mno)
        PUBLICATIONS="aftenposten bt sa fvn adressa"
        sources="vertikal sprek"
        mode="mno"
        specials=( "sprek" "bil" )
    ;;
    mnovertikal)
        PUBLICATIONS="aftenposten bt sa fvn adressa"
        sources="vertikal"
        mode="mno"
        specials=( "bil" )
    ;;
    mnosprek)
        PUBLICATIONS="aftenposten bt sa fvn adressa"
        sources="sprek"
        mode="mno"
        specials=( "sprek" )
    ;;
    esac
fi

MINIFYPATH=/opt/escenic_${mode}/minified_files

if [ "$PUBLICATIONS" = "" ]
then
    echo "No valid publication"
    exit
fi

if [ "$host" = "" ]
then
   echo "host is missing"
   exit
fi
JAVA_HOME=/usr/lib/jvm/java-6-sun
PATH="$JAVA_HOME/bin:$PATH"
export JAVA_HOME PATH

cd $(dirname $0)

case $host in
   dev)
      cp ${MINIFYPATH}/css/* ${webdir}/css
      cp ${MINIFYPATH}/js/* ${webdir}/js
   ;;
   test)
      scp ${MINIFYPATH}/css/* ${test_host}:${webdir}/css
      scp ${MINIFYPATH}/js/* ${test_host}:${webdir}/js
   ;;
   pub1)
      scp ${MINIFYPATH}/css/* ${pub1_host}:${webdir}/css
      scp ${MINIFYPATH}/js/* ${pub1_host}:${webdir}/js
   ;;
   pub2)
      scp ${MINIFYPATH}/css/* ${pub2_host}:${webdir}/css
      scp ${MINIFYPATH}/js/* ${pub2_host}:${webdir}/js
   ;;
esac
