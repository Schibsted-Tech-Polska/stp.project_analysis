#!/bin/bash
if [ "$1" = "" ]
then
  echo "Usage:"
  echo "$0 ap5|sa5|bt5|fvn5|mnovertikal|mnosprek [exclude]"
  exit
fi

test=0
debug="false"
exclude=""
if [ "$2" != "" ]
then
   if [ "$2" = "test" ]; then
      test=1
   elif [ "$2" = "debug" ]; then
      test=1
	  debug="true"	      
   fi
   if [ "$2" = "exclude" ]; then
      exclude="true"
   fi
fi
deploy_host=""
hostname=$(hostname)
case $hostname in
   eceadmin.aftenposten.no)
      echo "prod mode"
      deploy_host="prod"
      ;;
   *)
      echo "dev mode"
      deploy_host="local"
   ;;
esac
mode="$1"

if [ "${mode}" != "" ]
then
    case $1 in
    ap5)
        PUBLICATIONS="ap osloby"
        sources=mnofr
        warname=ap
        webdir=/data/webapps/ap/ap
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

if [ "$PUBLICATIONS" = "" ]
then
    echo "No valid publication"
    exit
fi

JAVA_HOME=/usr/lib/jvm/java-6-sun
PATH="$JAVA_HOME/bin:$PATH"
export JAVA_HOME PATH

if [ ! -d "target/dependency" ]; then
   mvn dependency:copy-dependencies
fi

cd $(dirname $0)

for source in ${sources}
do
    WEBAPPPATH=/opt/escenic_${mode}/assemblytool/publications/${source}/src/main/webapp
    #WEBAPPPATH=/opt/escenic_${mode}/assemblytool/publications/${source}/target/mnofr-publication-1.4.0
    SOURCEPATH=/opt/escenic_${mode}/assemblytool/publications/${source}
    CONFIGPATH=/opt/escenic_${mode}/assemblytool/publications/${source}/src/main/webapp/resources/minify-config

    case ${source} in
       vertikal)
           MINIFYPATH=/opt/escenic_${mode}/minified_${source}_files
       ;;
       sprek)
       ;;
       *)
        MINIFYPATH=/opt/escenic_${mode}/minified_files
       ;;
    esac

    echo minifying...

    # creating folders
    mkdir -p ${MINIFYPATH}/css ${MINIFYPATH}/js

    for pub in ${PUBLICATIONS}
    do
        echo "Processing $WEBAPPPATH"

        case ${source} in
           vertikal|sprek)
              for s in ${specials}
              do
                    java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main -appPath $WEBAPPPATH -skipListCss "${CONFIGPATH}/skipListCss.txt" -lastOrderListCss "${CONFIGPATH}/lastOrderListCss.txt" -orderListCss "${CONFIGPATH}/orderListCss.txt" -url "/css/" -pubDir "skins/publications/${pub}" -specGlobalDir "skins/specials/${s}/global" -specPubDir "skins/specials/${s}/publications/${pub}" -minifyAll true -minify css -cssMinifyPath ${MINIFYPATH}/css
                    mv cssInclude.html ${MINIFYPATH}/css/cssInclude_${pub}_${s}.html
              done
           ;;
           *)
                if [ "$exclude" = "" ]
                then
                    java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main -debug $debug -appPath $WEBAPPPATH -skipListCss "${CONFIGPATH}/skipListCss_${pub}.txt" -lastOrderListCss "${CONFIGPATH}/lastOrderListCss.txt" -orderListCss "${CONFIGPATH}/orderListCss.txt" -url "/css/" -pubDir "skins/publications/${pub}" -minifyAll true -minify css -cssMinifyPath ${MINIFYPATH}/css
                else
                    java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main  -debug $debug -appPath $WEBAPPPATH -excludeMinifyCss "${CONFIGPATH}/excludeCss.txt" -skipListCss "${CONFIGPATH}/skipListCss.txt" -lastOrderListCss "${CONFIGPATH}/lastOrderListCss.txt" -orderListCss "${CONFIGPATH}/orderListCss.txt" -url "/css/" -pubDir "skins/publications/${pub}" -minifyAll true -minify css -cssMinifyPath ${MINIFYPATH}/css
                fi
                echo
                mv cssInclude.html ${MINIFYPATH}/css/cssInclude_${pub}.html
           ;;
        esac

        # Processing javascript
        java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main -appPath $WEBAPPPATH -skipListJs "${CONFIGPATH}/skipListJs.txt" -compressOrderListJs "${CONFIGPATH}/compressOrderListJs.txt" -prependOrderNoMinifyJs "${CONFIGPATH}/prependOrderNoMinifyJs.txt" -url "/js/" -minifyAll true -minify js -jsMinifyPath ${MINIFYPATH}/js
        echo
        mv jsInclude.html ${MINIFYPATH}/js

        if [ -f "${CONFIGPATH}/mobileCss_${pub}.txt" ]
        then
            java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main -appPath $WEBAPPPATH -mobileCssList "${CONFIGPATH}/mobileCss_${pub}.txt" -url "/css/" -minifyAll true -minify cssMobile -cssMinifyPath ${MINIFYPATH}/css
            echo
            mv cssMobileInclude.html ${MINIFYPATH}/css/cssMobileInclude_${pub}.html
        fi

        if [ -f "${CONFIGPATH}/mobileJs_${pub}.txt" ]
        then
            java -Djava.ext.dirs=target/dependency -cp ./target/minifier.jar no.mno.minifier.Main -appPath $WEBAPPPATH -mobileJsList "${CONFIGPATH}/mobileJs_${pub}.txt" -url "/js/" -minifyAll true -minify jsMobile -jsMinifyPath ${MINIFYPATH}/js
            echo
            mv jsMobileInclude.html ${MINIFYPATH}/js/jsMobileInclude_${pub}.html 
        fi

        # Createing css/js list
        # empty the list
        echo "" > ${MINIFYPATH}/css/css.lst
        list=$(find ${SOURCEPATH}/src/main/webapp/skins -name "*.css" | sort)
        for v in $list
        do
          if [[ $v == *skins\/publications* ]]
          then
             if [[ $v == *skins\/publications\/${pub}* ]]
             then
                echo $v | cut -b $(( ${#SOURCEPATH} + 17 ))- >> ${MINIFYPATH}/css/css.lst
             fi
          else
             echo $v | cut -b $(( ${#SOURCEPATH} + 17 ))- >> ${MINIFYPATH}/css/css.lst
          fi
        done
    done
done

# creating a js lst
# empty the list
echo "" > ${MINIFYPATH}/js/js.lst
if [ ! -d "${SOURCEPATH}/src/main/webapp/resources" ]; then
	list=$(find ${SOURCEPATH}/src/main/webapp/resources -name "*.js")
	for v in $list
	do
	  echo $v | cut -b $(( ${#SOURCEPATH} + 17 ))- >> ${MINIFYPATH}/js/js.lst
	done
	
	if [ "$test" != 1 -a "$exclude" != "true" ]
	then
		# Predeploy the css and Javascripts to the external servers
		case $mode in
			ap5)
			   if [ "$deploy_host" = "prod" ]
				then
				   scp ${MINIFYPATH}/css/*.css apweb1.medianorge.no:/data/webapps/ap/ap/css
				   scp ${MINIFYPATH}/css/*.css apweb2.medianorge.no:/data/webapps/ap/ap/css
				   scp ${MINIFYPATH}/css/*.css apweb3.medianorge.no:/data/webapps/ap/ap/css
				   scp ${MINIFYPATH}/css/*.css apweb4.medianorge.no:/data/webapps/ap/ap/css
	
				   scp ${MINIFYPATH}/js/*.js apweb1.medianorge.no:/data/webapps/ap/ap/js
				   scp ${MINIFYPATH}/js/*.js apweb2.medianorge.no:/data/webapps/ap/ap/js
				   scp ${MINIFYPATH}/js/*.js apweb3.medianorge.no:/data/webapps/ap/ap/js
				   scp ${MINIFYPATH}/js/*.js apweb4.medianorge.no:/data/webapps/ap/ap/js
				else
				   echo "Copying minified css and js to the webapp"
			   mkdir -p /data/webapps/ap/ap/css
			   mkdir -p /data/webapps/ap/ap/js
				   cp ${MINIFYPATH}/css/* /data/webapps/ap/ap/css
				   cp ${MINIFYPATH}/js/* /data/webapps/ap/ap/js
				fi
			;;
			bt5)
				scp ${MINIFYPATH}/css/*.css btweb3.medianorge.no:/data/webapps/bt/bt/css
				scp ${MINIFYPATH}/css/*.css btweb4.medianorge.no:/data/webapps/bt/bt/css
	
				scp ${MINIFYPATH}/js/*.js btweb3.medianorge.no:/data/webapps/bt/bt/js
				scp ${MINIFYPATH}/js/*.js btweb4.medianorge.no:/data/webapps/bt/bt/js
			;;
			sa5)
				scp ${MINIFYPATH}/css/*.css saweb3.medianorge.no:/data/webapps/sa/sa/css
				scp ${MINIFYPATH}/css/*.css saweb4.medianorge.no:/data/webapps/sa/sa/css
	
				scp ${MINIFYPATH}/js/*.js saweb3.medianorge.no:/data/webapps/sa/sa/js
				scp ${MINIFYPATH}/js/*.js saweb4.medianorge.no:/data/webapps/sa/sa/js
			;;
			fvn5)
			   if [ "$deploy_host" = "prod" ]
				then
						scp ${MINIFYPATH}/css/*.css fvnweb1.medianorge.no:/data/webapps/sa/sa/css
						scp css/*.css fvnweb2.medianorge.no:/data/webapps/sa/sa/css
			
						scp ${MINIFYPATH}/js/*.js fvnweb1.medianorge.no:/data/webapps/sa/sa/js
						scp ${MINIFYPATH}/js/*.js fvnweb2.medianorge.no:/data/webapps/sa/sa/js
			else
				echo "Copying minified css and js to the webapp - ${webdir}"
				mkdir -p ${webdir}/css
				mkdir -p ${webdir}/js
					cp ${MINIFYPATH}/css/* ${webdir}/css
					cp ${MINIFYPATH}/js/* ${webdir}/js
				fi
			;;
			mno|mnovertikal|mnosprek)
				for app in ${sources}
				do
				   case "$app" in
					  vertikal)
						scp ${MINIFYPATH}/js/*.js mnoweb1.medianorge.no:/data/webapps/mno/vertikal/js
						scp ${MINIFYPATH}/js/*.js mnoweb2.medianorge.no:/data/webapps/mno/vertikal/js
					  ;;
					  sprek)
						scp ${MINIFYPATH}/js/*.js mnoweb1.medianorge.no:/data/webapps/mno/sprek/js
						scp ${MINIFYPATH}/js/*.js mnoweb2.medianorge.no:/data/webapps/mno/sprek/js
					  ;;
				   esac
				done
			;;
		esac
	fi
fi

# Patching the war files...
for source in ${sources}
do
    WEBAPPPATH=/opt/escenic_${mode}/assemblytool/publications/${source}/target/mnofr-publication-1.4.0
    case ${source} in
       vertikal)
           MINIFYPATH=/opt/escenic_${mode}/minified_${source}_files
           warname=vertikal
       ;;
       sprek)
           MINIFYPATH=/opt/escenic_${mode}/minified_${source}_files
           warname=sprek
       ;;
       *)
           MINIFYPATH=/opt/escenic_${mode}/minified_files
       ;;
    esac
	
	if [ -f "$WEBAPPPATH.war" ]; then
		# Updating previously build war files
		cd ${MINIFYPATH}
		echo Adding css to  $WEBAPPPATH.war
		jar uvf $WEBAPPPATH.war css/*
		echo Adding js to  $WEBAPPPATH.war
		jar uvf $WEBAPPPATH.war js/*
	
		# Updating warfiles in assemblytool/dist/war
		echo Adding css to /opt/escenic_${mode}/assemblytool/dist/war/${warname}.war
		jar uvf /opt/escenic_${mode}/assemblytool/dist/war/${warname}.war css/*
		echo Adding js to /opt/escenic_${mode}/assemblytool/dist/war/${warname}.war
		jar uvf /opt/escenic_${mode}/assemblytool/dist/war/${warname}.war js/*
	fi
	
done
