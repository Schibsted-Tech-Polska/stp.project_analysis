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
sudo apt-get install subversion
sudo apt-get install maven
sudo apt-get install ant
sudo apt-get install node
sudo apt-get install npm

fi

sudo npm install
sudo npm install -g mocha
sudo npm install -g plato

wget http://repository.codehaus.org/org/codehaus/sonar-plugins/javascript/sonar-javascript-plugin/1.3/sonar-javascript-plugin-1.3.jar
mv sonar-javascript-plugin-1.3.jar sonar-3.6.1/extensions/plugins/

wget http://repository.codehaus.org/org/codehaus/sonar-plugins/php/sonar-php-plugin/1.2/sonar-php-plugin-1.2.jar
mv sonar-php-plugin-1.2.jar sonar-3.6.1/extensions/plugins/

wget http://repository.codehaus.org/org/codehaus/sonar-plugins/sonar-groovy-plugin/0.6/sonar-groovy-plugin-0.6.jar
mv sonar-groovy-plugin-0.6.jar sonar-3.6.1/extensions/plugins/

#exporting path variable for sonar-runner
cd ..
sh startApplication.sh



