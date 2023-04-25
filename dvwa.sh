#!/bin/bash
sudo apt update

sudo apt-get -y install apache2 mariadb-server php php-mysqli php-gd libapache2-mod-php

sudo mysqladmin create dvwa

sudo mysql dvwa << EOF
create user dvwa@localhost identified by 'p@ssw0rd';
grant all on dvwa.* to dvwa@localhost;
flush privileges;
EOF

cd /var/www/html
sudo rm /var/www/html/index.html
sudo git clone https://github.com/digininja/DVWA.git .
sudo cp config/config.inc.php.dist config/config.inc.php
sudo chown www-data:www-data /var/www/html/hackable/uploads/
sudo chown www-data:www-data /var/www/html/external/phpids/0.6/lib/IDS/tmp/phpids_log.txt
sudo chown www-data:www-data /var/www/html/config


sudo sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php/7.2/apache2/php.ini
sudo apache2ctl restart
