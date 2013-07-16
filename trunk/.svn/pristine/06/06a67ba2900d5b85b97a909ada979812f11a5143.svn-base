#!/bin/bash

function resolveVersion() {
   echo "Version: $WEBAPPPATH"
}


if [ "$1" = "" ]
then
  echo "Usage:"
  echo "$0 ap5|sa5|bt5|fvn5|mnovertikal|mnosprek [exclude]"
  exit
fi
deploy_host=""
hostname=$(hostname)
case $hostname in
   eceadmin.medianorge.no)
      echo "prod mode"
      deploy_host="prod"
      ;;
   *)
      exit
   ;;
esac
mode="$1"

CSS_RESOURCE_PATH="/data/include/css"
JS_RESOURCE_PATH="/data/include/js"

if [ "${mode}" != "" ]
then
    case $mode in
    ap5)
        WEBSERVERS="apweb1.medianorge.no apweb2.medianorge.no apweb3.medianorge.no apweb4.medianorge.no"
    ;;
    bt5)
        WEBSERVERS="btweb3.medianorge.no btweb4.medianorge.no"
    ;;
    sa5)
        WEBSERVERS="saweb3.medianorge.no saweb4.medianorge.no"
    ;;
    fvn5)
        WEBSERVERS="fvnweb1.medianorge.no fvnweb2.medianorge.no"
    ;;
    *)
        exit
    esac
fi

if [ "$WEBSERVERS" = "" ]
then
    echo "No valid publication"
    exit
fi

cd $(dirname $0)
WEBAPPPATH="/opt/escenic_${mode}/assemblytool/publications/mnofr/target/mnofr-publication-1.4.0"
if [ ! -d "$WEBAPPPATH" ]
then
    echo "Missing folder: $WEBAPPPATH"
    exit
fi
WAR="/opt/escenic_${mode}/assemblytool/publications/mnofr/target/mnofr-publication-1.4.0.war"
if [ ! -f "$WAR" ]
then
    echo "File doesn't exist: $WAR"
    exit
fi

# Resolving subversion revision from the previously created war-file
SVNREVISION=$(unzip -p ${WAR}  WEB-INF/classes/version_mnofr-publication.xml | xmlstarlet sel -t -v "//entry/@revision")

if [ "${SVNREVISION}" != "" ]
then
    for server in ${WEBSERVERS}
    do
        # Copying the stylesheets and javascripts to /data/include/js and /data/include/css on the webservers
	    echo "Copying resources to: ${server}"
        ssh ${server} mkdir -p /data/include/css/${SVNREVISION}
        scp -r -p ${WEBAPPPATH}/skins/ ${server}:/data/include/css/${SVNREVISION}/skins/
        ssh ${server} mkdir -p /data/include/js/${SVNREVISION}
        scp -r -p ${WEBAPPPATH}/resources/js ${server}:/data/include/js/${SVNREVISION}/js
    done
fi
