 #!/bin/bash
sudo -i
proxy=$1

if [ -n "$proxy" ]; then
	export http_proxy=$proxy
	export https_proxy=$proxy
	export no_proxy='no_proxy=localhost,127.0.0.1'

	echo 'host.env 10.0.2.2' >> /etc/hosts 

	echo 'vagrant: setting proxy in environment variables'
	echo 'http_proxy="'$proxy'"' >> /etc/environment
	echo 'https_proxy="'$proxy'"' >> /etc/environment
	echo 'ftp_proxy="'$proxy'"' >> /etc/environment
	echo 'no_proxy=localhost,127.0.0.1,host.env,10.0.2.2,127.0.1.1' >> /etc/environment

	echo "export http_proxy='$proxy'" >> /etc/default/docker
	echo "export https_proxy='$proxy'" >> /etc/default/docker
	. /etc/environment

	touch /etc/apt/apt.conf
	echo 'acquire::http::proxy "'$proxy'";' >> /etc/apt/apt.conf
	echo 'acquire::https::proxy "'$proxy'";' >> /etc/apt/apt.conf
	echo 'acquire::ftp::proxy "'$proxy'";' >> /etc/apt/apt.conf
fi

echo 'vagrant: setting apt-get sources'
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# this tells apt-get to preload mysql-5.5 password to avoid its interactive setup
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password password'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password password'

echo 'vagrant: apt-get update'
apt-get update

echo 'vagrant: installing dependencies'
apt-get install -y --force-yes \
  apt-transport-https \
  ca-certificates \
  lamp-server^ \
  linux-headers-$(uname -r) \
  linux-image-extra-$(uname -r) \
  linux-image-extra-virtual \
  php5-gd \
  php5-mcrypt \
  php5-curl \
  php5-xdebug \
  wireshark \
  nano \
  git \
  curl

#a2enmod rewrite
echo "ServerName localhost" >> /etc/apache2/apache2.conf
sed 's/80/8000/' /etc/apache2/ports.conf
sed 's/80/8000/' /etc/apache2/sites-enabled/000-default.conf

phpIni="/etc/php5/apache2/php.ini"
echo "zend_extension=$(find /usr/lib/php5/20121212/xdebug.so)" > $phpIni
echo "xdebug.remote_enable=on" >> $phpIni
echo "xdebug.idekey=phpstorm" >> $phpIni
echo "xdebug.remote_autostart=off" >> $phpIni
echo "xdebug.remote_host=10.0.2.2" >> $phpIni
echo "xdebug.report_port=9000" >> $phpIni
echo 'vagrant: fetching magento bits'
php5dismod xdebug

#map 80 to 8000 as per host environment
iptables -t nat -A OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 8000
#todo: automate apache2 listenport = 8000

curl -sS http://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

chown -R vagrant /var/www/html

mkdir /home/vagrant/.composer
chown -R vagrant /home/vagrant/.composer
cd /var/www/html
composer create-project magento/core magento/ -vvv
chmod -R a+rwx ./magento/
mv /var/www/html/magento/errors/local.xml.sample local.xml #enable detailed errors - DO NOT USE IN PROD
php5enmod xdebug
php5enmod mcrypt
php5enmod curl
service apache2 restart

mysql -u root -ppassword -e "CREATE DATABASE IF NOT EXISTS magento;"
mysql -u root -ppassword -e "GRANT ALL ON magento.* TO magento@localhost IDENTIFIED BY 'magento';"
mysql -u root -ppassword -e "GRANT SUPER ON *.* TO 'magento'@'localhost';"