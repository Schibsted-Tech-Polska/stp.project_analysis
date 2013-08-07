if [ "$(uname -s)" == "Darwin" ];then #this is mac
sh env/sonar-3.6.1/bin/macosx-universal-64/sonar.sh stop
else
sh env/sonar-3.6.1/bin/linux-x86-64/sonar.sh stop
fi
