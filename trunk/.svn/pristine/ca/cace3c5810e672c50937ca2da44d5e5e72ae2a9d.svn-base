#! /bin/sh

cd `dirname $0`
mydir=`pwd`

user="mno"
base=`basename $0 .sh`
err="$mydir/$base.err"
logf="adtech-`date +%Y-%m-%d`.log"

# include server names
btservers="btpub2.medianorge.no btpub3.medianorge.no btweb3.medianorge.no btweb4.medianorge.no bttest2.medianorge.no"

printf "" >$err

{
if (/usr/lib/jvm/java-6-sun-1.6.0.22/bin/java -cp .:/home/mno/adtech/lib/HeliosWSClientSystem_1.5.4.jar:/home/mno/adtech/lib/security-ng.jar:/home/mno/adtech/lib/security2-ng.jar:/home/mno/adtech/lib/security_providers_client.jar:/home/mno/adtech/lib/wasp.jar:/home/mno/adtech/lib/saaj.jar:/home/mno/adtech/lib/wsdl_api.jar:/home/mno/adtech/lib/security_services_client.jar:/home/mno/adtech/lib/core_services_client.jar:/home/mno/adtech/lib/builtin_serialization.jar:/home/mno/adtech/lib/activation.jar:/home/mno/adtech/lib/jaxrpc.jar:/home/mno/adtech/lib/jetty.jar:/home/mno/adtech/lib/Adtech.jar no.aftenposten.adtech.GetCampaigns Tore Paasporet2010 https://ws.adtech.de /home/mno/adtech/xml/)
then
	tar --create --directory xml --exclude heliosconfig.tgz --gzip --file xml/heliosconfig.tgz .
	# Download OK
	# AI
	for s in $btservers
	do
		if (rsync -av --timeout=120 --delay-updates --delete xml/ $user@$s:/data/import/heliosconfig/)
		then
			:
		else
			echo "SYNC:$s" >>$err
		fi
	done
else
	echo GENERATE >>$err
fi
} >>log/$logf 2>&1
find log -type f -name "*.log" -mtime +30 -delete
