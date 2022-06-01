# check if jdk-11 is installed, if not install it
if [ ! -d /usr/lib/jvm/java-11-openjdk-amd64 ]; then
  echo "Installing Java 11"
  sudo apt-get install -y openjdk-11-jdk
fi

# check if maven3.6 is installed, if not install it
if [ ! -d /usr/share/maven ]; then
  echo "Installing Maven"
  sudo apt-get install -y maven
fi
