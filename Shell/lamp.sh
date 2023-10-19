#!/bin/bash

# chmod +x lamp.sh

# LAMP server Script on Ubuntu 23.10
# https://github.com/tigrouuu

#https://www.digitalocean.com/community/tutorials/how-to-install-linux-apache-mysql-php-lamp-stack-on-ubuntu-22-04
#https://www.digitalocean.com/community/tutorials/how-to-install-and-secure-phpmyadmin-on-ubuntu-22-04

# Check if script is being run by root
#if [[ $EUID -ne 0 ]]; then
#    printf "This script must be run as root!\n"
#    exit 1
#fi

ASTERIC="\n***************************************\n\n"
DIVIDER="\n_______________________________________\n\n"

# Welcome and instructions
printf $ASTERIC
printf "LAMP server setup on Ubuntu\n"
printf $ASTERIC

# Install and update software
printf $DIVIDER
printf "INSTALL AND UPDATE SOFTWARE\n"
printf "Now the script will update Ubuntu and install all the necessary software.\n"
printf " * You will be prompted to enter the password for the MySQL root user\n"
read -p "Please ENTER to continue "
printf "Repository update...\n"
sleep 2
sudo apt-get -y update
sleep 2

printf "Upgrade installed packages...\n"
sleep 2
sudo apt-get -y upgrade
slepp 2

# Install Apache2
printf $DIVIDER
printf "INSTALL APACHE\n"
sleep 2
sudo apt install apache2
sleep 2

# Install Firewall Gufw and allow Apache
printf $DIVIDER
printf "INSTALL GUFW AND ALLOW APACHE\n"
sleep 2
sudo apt install gufw
sudo ufw app list
sudo apt install openssh
sudo apt install ssh
sudo ufw app list
sudo ufw allow in "Apache Full"
sleep 2

# Install MySQL
printf $DIVIDER
printf "INSTALL MYSQL\n"
sleep 2
sudo apt install mysql-server
sudo mysql_secure_installation
sudo mysql
sleep 2

# Install PHP
printf $DIVIDER
printf "INSTALL PHP\n"
sleep 2
sudo apt install php libapache2-mod-php php-{common,bcmath,bz2,curl,gd,imap,intl,json,mbstring,mysql,pear,redis,snmp,soap,tokenizer,xml,xmlrpc,zip}
sudo phpenmod mbstring
sleep 2

# Test PHP -v & -m
printf $DIVIDER
printf "TEST PHP -v & -m\n"
sleep 2
php -m
php -v
sleep 2

# Install PhpMyyAdmin
printf $DIVIDER
printf "INSTALL PHPMYADMIN\n"
sleep 2
sudo apt install phpmyadmin
sleep 2

# Configure PhpMyyAdmin
printf $DIVIDER
printf "CONFIGURE PHPMYADMIN\n"
printf "Please copy the following line for the next command : ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';\n\n"

while true; do
	read -p "Press Y to continue." cnt3
	case $cnt3 in
		[Yy]* ) break;;
		* ) printf "Please press Y to continue.\n";;
	esac
done

sudo mysql

printf "Please copy the following lines for the next command :\n\n"
printf "CREATE USER 'tigrou'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'tigrou';\n
ALTER USER 'tigrou'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tigrou';\n
GRANT ALL PRIVILEGES ON *.* TO 'tigrou'@'localhost' WITH GRANT OPTION;\n
exit\n"

while true; do
	read -p "Press Y to continue." cnt3
	case $cnt3 in
		[Yy]* ) break;;
		* ) printf "Please press Y to continue.\n";;
	esac
done

mysql -u root -p
sleep 2

printf "Add an AllowOverride All directive within the <Directory /usr/share/phpmyadmin> section of the configuration file :\n\n"
printf "AllowOverride All\n"

while true; do
	read -p "Press Y to continue." cnt3
	case $cnt3 in
		[Yy]* ) break;;
		* ) printf "Please press Y to continue.\n";;
	esac
done

sudo nano /etc/apache2/conf-available/phpmyadmin.conf
sudo systemctl restart apache2
sleep 2

# Clean apt
printf $DIVIDER
printf "CLEAN APT\n"
sleep 2
sudo apt clean && sudo apt autoclean && sudo apt autoremove
sleep 2

# Install composer
printf $DIVIDER
printf "INSTALL COMPOSER\n"
sleep 2
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer

sudo -u www-data composer --version
sudo chmod +x /usr/local/bin/composer
sleep 2

# Test Composer -V
printf $DIVIDER
printf "TEST COMPOSER -V\n"
sleep 2
composer -V
sleep 2

# Install Node.js
printf $DIVIDER
printf "INSTALL NODE.JS\n"
sleep 2
sudo snap install node --channel=20/stable --classic
sleep 2

# Install Laravel globally
printf $DIVIDER
printf "INSTALL LARAVEL GLOBALLY\n"
sleep 2
sudo composer global require laravel/installer
sleep 2

# Test Node -v & Npm -v
printf $DIVIDER
printf "TEST NODE -v & NPM -v\n"
sleep 2
node -v
npm -v
sleep 2

# The End
printf $DIVIDER
printf "The script executing has finished. Please check messages for any errors.\n"
read -p "Press ENTER to continue"

exit

________________________________________________________________________________

: 'sudo apt-get update -y && sudo apt-get upgrade -y

sudo apt install apache2

sudo apt install gufw
sudo ufw app list
sudo apt install openssh
sudo apt install ssh
sudo ufw app list
sudo ufw allow in "Apache Full"

sudo apt install mysql-server
sudo mysql_secure_installation
sudo mysql

sudo apt install php libapache2-mod-php php-{common,bcmath,bz2,curl,gd,imap,intl,json,mbstring,mysql,pear,redis,snmp,soap,tokenizer,xml,xmlrpc,zip}

php -m
php -v

sudo apt install phpmyadmin

sudo mysql
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

mysql -u root -p
CREATE USER 'tigrou'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'tigrou';
ALTER USER 'tigrou'@'localhost' IDENTIFIED WITH mysql_native_password BY 'tigrou';
GRANT ALL PRIVILEGES ON *.* TO 'tigrou'@'localhost' WITH GRANT OPTION;
exit

sudo nano /etc/apache2/conf-available/phpmyadmin.conf
#Add an AllowOverride All directive within the <Directory /usr/share/phpmyadmin> section of the configuration file
AllowOverride All
sudo systemctl restart apache2

sudo apt clean && sudo apt autoclean && sudo apt autoremove

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer

sudo -u www-data composer --version
sudo chmod +x /usr/local/bin/composer

sudo composer global require laravel/installer'
