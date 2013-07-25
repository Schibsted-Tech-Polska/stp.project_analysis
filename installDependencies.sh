mkdir env
cd ./env/


if [ -f "sonar-3.6.1.zip" ]
then
echo "sonar already downloaded"
else
wget http://dist.sonar.codehaus.org/sonar-3.6.1.zip
unzip sonar-3.6.1.zip
wget http://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.2.2/sonar-runner-dist-2.2.2.zip
unzip sonar-runner-dist-2.2.2.zip
fi

if [ "$(uname -s)" == "Darwin" ];then #this is mac
sudo brew install git
sudo brew install subversion
sudo brew install maven
sudo brew install node
#ant is already on mac


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

npm install


