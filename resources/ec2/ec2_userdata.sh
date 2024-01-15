#!/bin/bash
cd /var
mkdir www

apt-get install -y curl
curl -sL https://deb.nodesource.com/setup_20.x -o /tmp/nodesource_setup.sh
chmod 700 /tmp/nodesource_setup.sh 
/tmp/nodesource_setup.sh 

apt-get install -y nodejs
npm i -g pm2

apt-get update -y
apt-get install git -y

timedatectl set-timezone 'Asia/Seoul'
