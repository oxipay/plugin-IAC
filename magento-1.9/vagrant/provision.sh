 #!/bin/bash
echo 'vagrant: fetching magento bits'

#map 80 to 8000 as per host environment
sudo iptables -t nat -A OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 8000

sudo apt-get install php5-mcrypt php5-curl

curl -sS http://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
mysql -u root -ppassword -e "CREATE DATABASE IF NOT EXISTS magento;"
mysql -u root -ppassword -e "GRANT ALL ON magento.* TO magento@localhost IDENTIFIED BY 'magento';"
mysql -u root -ppassword -e "GRANT SUPER ON *.* TO 'magento'@'localhost';"

cd /var/www/html
sudo php5dismod xdebug
sudo service apache2 restart
chown -R vagrant /var/www/html
mkdir /home/vagrant/.composer
chown -R vagrant /home/vagrant/.composer

composer create-project magento/core magento/ -vvv

sudo chmod -R a+rwx ./magento/
sudo php5enmod xdebug
sudo php5enmod mcrypt
sudo php5enmod curl
sudo service apache2 restart