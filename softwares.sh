#!/bin/bash

function install_ansible()
{
  # Add repository before installing
  sudo apt-get update 
  sudo apt-get install software-properties-common 
  sudo apt-add-repository ppa:ansible/ansible
  sudo apt-get update 
  sudo apt-get install ansible
}

function install_jenkins()
{
  sudo apt-get update
  # Install Java 8
  sudo apt-get install openjdk-8-jdk
  
  # Import GPG Keys of jenkins repository
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  
  sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo apt-get update
  sudo apt-get install jenkins
  
  # Start the jenkins service
  sudo systemctl start jenkins
  
  # Enable jenkins to start on boot up
  sudo systemctl enable jenkins
}

function install_docker()
{
  # Remove any previous docker packages are there
  sudo apt-get remove docker docker-engine docker.io containerd runc
  
  # Install following packages to download over HTTPS Connections
  sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
    
  # Get the docker GPG Key
  curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
  
  # Search the key using last 8 characters of the GPG Key
  sudo apt-key fingerprint 0EBFCD88
  
  # Add Docker repository
  # For x86_64/amd64 Machines
  sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
   
 sudo apt-get update
 # Install Docker
 sudo apt-get install docker-ce docker-ce-cli containerd.io
 
 # If we want to install only particular version
 # Search the repository for available versions
 apt-cache madison docker-ce
 
 # Install specific version using
 sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io
 
 # Installing Docker-Compose
 sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
 sudo chmod +x /usr/local/bin/docker-compose
 sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
}

# Install Chrome on Debian9
function install_chrome()
{
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt-get --fix-broken install
  sudo dpkg -i google-chrome-stable_current_amd64.deb
}
