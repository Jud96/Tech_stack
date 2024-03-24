## Installation on ubuntu

# Confirm KVM virtualization is enabled
lsmod | grep kvm
#If the module is loaded, you should get the following output. 
#This shows that the KVM module for the Intel CPU is enabled.

#If the module is not loaded, you can run the following commands:
#For Intel Processors
sudo modprobe kvm_intel
#For AMD Processors
sudo modprobe kvm_amd

#Install Docker on Ubuntu 22.04
sudo apt update
sudo apt install software-properties-common curl apt-transport-https ca-certificates -

#Once the installation is complete, add Docker’s GPG signing key.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/docker-archive-keyring.gpg

#add the official Docker’s repository to your system as follows
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install Docker and other Docker tools as shown.
sudo apt install docker-ce docker-ce-cli containerd.io uidmap -y

# After successful installation, add the user account to the Docker group using the following commands
sudo usermod -aG docker $USER
newgrp docker

# verify
sudo systemctl status docker
docker version

# Install Docker Desktop
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-4.15.0-amd64.deb
sudo apt install ./docker-desktop-*-amd64.deb
# launch from GUI or termainal 
sudo systemctl --user start docker-desktop
# if you have any problem run the next command 
systemctl --user enable docker-desktop