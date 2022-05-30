# we need to install "unzip" to un-zip the zip files
sudo apt-get install unzip -y

# files needed for gitpod
wget 

# install maridb
sudo apt-get update -y
sudo apt-get install mariadb-server -y

# setup mysql(unsecure)
sudo service mysql start

# create database(without password)
sudo mysql -uroot -Bse  "create database sakaidb  default character set utf8; create user 'sakaiuser'@'localhost' identified by 'sakaipassword';grant all on *.* to 'sakaiuser'@'localhost';
  create user 'sakaiuser'@'127.0.0.1' identified by 'sakaipassword';
  grant all on *.* to 'sakaiuser'@'127.0.0.1';
  flush privileges;
"

# create sakai.properties in home directory
cd

wget https://github.com/kunaljaykam/kj-sakai/raw/main/sakai-gitpod-template/sakai.properties.zip


unzip sakai.properties.zip

# we don't need the zip file anymore
rm sakai.properties.zip


# install apache tomcat
wget https://github.com/kunaljaykam/kj-sakai/raw/main/sakai-gitpod-template/tomcat9.zip

unzip tomcat9.zip

# we don't need the zip file anymore
rm tomcat9.zip

# make the tomcat bin directory executable
chmod +x tomcat9/bin/*.sh

# build sakai(skip tests) and deploy
cd /workspace/sakai

mvn clean install -Dmaven.test.skip=true -T 4C -Dmaven.tomcat.home=/home/gitpod/tomcat9 -Dsakai.home=/home/gitpod/ sakai:deploy


# Finally, start the tomcat
cd ~/tomcat9

bin/startup.sh; tail -f logs/catalina.out