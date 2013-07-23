mkdir env
cd ./env/

wget http://dist.sonar.codehaus.org/sonar-3.6.1.zip
unzip sonar-3.6.1.zip
wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.2.2/sonar-runner-dist-2.2.2.zip
unzip sonar-runner-dist-2.2.2.zip

if [ "$(uname -s)" == "Darwin" ];then #this is mac
brew install git
brew install subversion
brew install maven
brew install node
#ant is already on mac

#start sonar server, will be listen on port 9000
sh ./env/sonar-3.6.1/bin/macosx-universal-64/sonar.sh start
#TODO node app.js
else
yum install apt
yum install apt-get

sudo apt-get install git

yum install subversion
sudo apt-get install subversion

sudo apt-get install maven

sudo apt-get install ant

sudo apt-get install nodejs
sh ./env/sonar-3.6.1/bin/linux-x86-32/sonar.sh start
fi

#exporting path variable for sonar-runnerls

export PATH=$HOME/env/sonar-runner-2.2.2/bin:$PATH



