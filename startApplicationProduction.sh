export NODE_ENV=production
export PATH="$PWD"/env/sonar-runner-2.2.2/bin:$PATH
#start sonar server, will be listen on port 9000
if [ "$(uname -s)" == "Darwin" ];then #this is mac
sh env/sonar-3.6.1/bin/macosx-universal-64/sonar.sh start
else
sh env/sonar-3.6.1/bin/linux-x86-64/sonar.sh start
fi

forever ./app.js