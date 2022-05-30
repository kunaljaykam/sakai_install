set -e

# check if jdk-11 is installed and ehco its version, if not install it
if [ ! -d /usr/lib/jvm/java-11-openjdk-amd64 ]; then
  echo "Installing Java 11"
  sudo apt-get install -y openjdk-11-jdk
fi

# check if maven is installed and echo its version, if not install it
if [ ! -d /usr/share/maven ]; then
  echo "Installing Maven"
  sudo apt-get install -y maven
fi

# set paths of java and maven and execute the shell script
echo "export JAVA_HOME=/opt/java/11.0.16" >> ~/.bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc
echo "export MAVEN_HOME=/opt/maven/3.6.3" >> ~/.bashrc
echo "export PATH=$PATH:$MAVEN_HOME/bin" >> ~/.bashrc


echo "Installing the project"



