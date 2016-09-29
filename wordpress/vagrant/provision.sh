#!/bin/bash
sudo -i -E

proxy=$1

if [ -n "$proxy" ]; then
	export http_proxy=$proxy
	export https_proxy=$proxy
	export no_proxy='no_proxy=localhost,127.0.0.1'

	echo 'vagrant: setting proxy in environment variables'
	echo 'http_proxy="'$proxy'"' >> /etc/environment
	echo 'https_proxy="'$proxy'"' >> /etc/environment
	echo 'ftp_proxy="'$proxy'"' >> /etc/environment
	echo 'no_proxy="localhost,127.0.0.1"' >> /etc/environment

	echo "export http_proxy='$proxy'" >> /etc/default/docker
	echo "export https_proxy='$proxy'" >> /etc/default/docker
	. /etc/environment

	touch /etc/apt/apt.conf
	echo 'acquire::http::proxy "'$proxy'";' >> /etc/apt/apt.conf
	echo 'acquire::https::proxy "'$proxy'";' >> /etc/apt/apt.conf
	echo 'acquire::ftp::proxy "'$proxy'";' >> /etc/apt/apt.conf
fi

echo 'vagrant: setting apt-get sources'
touch /etc/apt/sources.list.d/docker.list
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' >> /etc/apt/sources.list.d/docker.list
add-apt-repository ppa:webupd8team/sublime-text-3

echo 'vagrant: getting gpg key for docker-engine'
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo 'vagrant: apt-get update'
apt-get update

echo 'vagrant: installing dependencies'
apt-get install -y --force-yes \
  apt-transport-https \
  ca-certificates \
  docker-engine \
  git

echo 'vagrant: download docker-compose'
curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose


# service docker start
# service docker restart #this is a weird hacky thing that seems to work --shrugs--
# docker run hello-world
# cd /src/wordpress-environment
# docker-compose up -d