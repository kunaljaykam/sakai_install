
# Install Sakai on Linux




We will need JDK-11, Maven-3.6, Mariadb-latest and tomcat-9

```bash
  # install jdk-11
   $ sudo apt-get install openjdk-11-jdk

  # install maven-3.6
   $ sudo apt-get install maven

  # install mariadb-server
   $ sudo apt-get install mariadb-server

```

Setup Mariadb for Sakai to use
```bash
  # start mysql
  $ sudo service mysql start

  # create database(unsecure)
  $ sudo mysql -uroot -Bse  "create database sakaidb  default character set utf8; create user 'sakaiuser'@'localhost' identified by 'sakaipassword';grant all on *.* to 'sakaiuser'@'localhost';
  create user 'sakaiuser'@'127.0.0.1' identified by 'sakaipassword';
  grant all on *.* to 'sakaiuser'@'127.0.0.1';
  flush privileges;"
```

Set paths for java
```bash
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
```
Create sakai.properties
```bash
$ touch ~/sakai-workspace/sakai.properties; gedit ~/sakai-workspace/sakai.properties
```
Copy and paste below code inside sakai.properties and replace the values with your own
```bash
# mysql username and password
username@javax.sql.BaseDataSource=sakaiuser
password@javax.sql.BaseDataSource=sakaipassword

## MySQL settings
vendor@org.sakaiproject.db.api.SqlService=mysql
driverClassName@javax.sql.BaseDataSource=org.mariadb.jdbc.Driver
hibernate.dialect=org.hibernate.dialect.MySQL5InnoDBDialect
url@javax.sql.BaseDataSource=jdbc:mysql://127.0.0.1:3306/sakaidb?useUnicode=true&characterEncoding=UTF-8?useSSL=false
validationQuery@javax.sql.BaseDataSource=select 1 from DUAL
defaultTransactionIsolationString@javax.sql.BaseDataSource=TRAN
```


Downlaod tomcat-9 and modify for Sakai to use it
```bash 
# create a dir and download tomcat
$ cd; mkdir sakai-workspace; cd sakai-workspace; wget https://github.com/kunaljaykam/tomcat/raw/main/tomcat-9.zip

# unzip tomcat and create a setevn.sh file inside tomcat9/bin directory
$ sudo apt-get unzip -y && cd ~/sakai-workspace/tomcat-9/bin; touch setenv.sh; gedit ~/sakai-workspace/tomcat-9/bin/setenv.sh
```


Copy and paste below codes inside tomcat-9/bin/setenv.sh and the replace the values with your own

  
  ```bash
export JAVA_OPTS="-server -Xmx4g -XX:MaxMetaspaceSize=1g -Djava.awt.headless=true -XX:+UseCompressedOops -XX:+UseConcMarkSweepGC -XX:+DisableExplicitGC -Djava.util.Arrays.useLegacyMergeSort=true"
JAVA_OPTS="$JAVA_OPTS -Dhttp.agent=Sakai"
JAVA_OPTS="$JAVA_OPTS -Dorg.apache.jasper.compiler.Parser.STRICT_QUOTE_ESCAPING=false"

# replace the following two(Dsakai.security & Dsakai.home) with your sakai.properties path
JAVA_OPTS="$JAVA_OPTS -Dsakai.security=/your sakai.properties path/"
JAVA_OPTS="$JAVA_OPTS -Dsakai.home=/your sakai.properties path/"

JAVA_OPTS="$JAVA_OPTS -Dsakai.cookieName=SAKAI2SESSIONID"
JAVA_OPTS="$JAVA_OPTS -Dsakai.demo=true"
JAVA_OPTS="$JAVA_OPTS -Duser.timezone=US/Eastern"
JAVA_OPTS="$JAVA_OPTS -Duser.language=en -Duser.region=ES"
```

