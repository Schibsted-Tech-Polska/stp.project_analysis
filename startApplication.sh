
export PATH="$PWD"/env/sonar-runner-2.2.2/bin:$PATH
#start sonar server, will be listen on port 9000
sh sonar-3.6.1/bin/macosx-universal-64/sonar.sh start
node ./app.js