#! /bin/bash

sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install maven -y

if [ -d "addressbook" ]
then
   echo "repo is already cloned and exists"
   cd /home/ec2-user/veera-addressbook
   git checkout test-practice
   git pull origin test-practice
else
   cd /home/ec2-user/veera-addressbook
   git clone https://github.com/veerachandra/addressbook.git
   git checkout test-practice
fi
echo "test-practice repo got updated using git pull origin test-practice"
mvn package
