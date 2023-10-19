#!/bin/bash

# chmod +x laravel.sh

# Laravel Virtual Host Script on Ubuntu 23.10
# https://github.com/tigrouuu

#https://medium.com/@josephajibodu/laravel-files-and-permissions-the-right-way-790e2919b2ed

# Check if script is being run by root
#if [[ $EUID -ne 0 ]]; then
#    printf "This script must be run as root!\n"
#    exit 1
#fi

ASTERIC="\n***************************************\n\n"
DIVIDER="\n_______________________________________\n\n"

# Welcome and instructions
printf $ASTERIC
printf "Laravel Virtual Host setup on Ubuntu\n"
printf $ASTERIC

## Create Laravel project with a virtual host

echo -n "Enter the project name in Laravel: "
read -r projectName

while true; do
	read -p "Do you confirm the project name \""$projectName"\"? [Y/N]? " cnt2
	case $cnt2 in
		[Yy]* ) break;;
		[Nn]* ) exit;; # Permettre de corriger le nom du projet !!!!
		* ) printf "Please answer Y or N\n";;
	esac
done

# Add a user to group www-data
userName=`whoami`

printf "Add a user \""$userName"\" to group www-data\n\n"
printf "`grep ^www-data /etc/group` \n\n"

sudo adduser $userName www-data
sudo usermod -a -G www-data $userName

printf "`grep ^www-data /etc/group` \n\n"
printf "`id $userName` \n\n"
printf "`groups $userName` \n\n"

sudo mkdir -p /var/www/$projectName
sudo chown -R www-data:www-data /var/www/$projectName
cd /var/www/$projectName

printf "\nThe \""$projectName"\" folder has been created. Installing Laravel...\n"
sleep 2

sudo -u www-data composer create-project laravel/laravel .

printf "\nLaravel installed successfully. Permission changes in progress...\n"

## Votre compte utilisateur en tant que propriétaire

sudo chown -R $USER:www-data /var/www/$projectName

sudo find /var/www/$projectName -type f -exec chmod 644 {} \;
sudo find /var/www/$projectName -type d -exec chmod 755 {} \;

# Donnez au serveur Web les autorisations de lecture et d'écriture dans les répertoires storage et bootstrap/cache comme requis par Laravel
sudo chgrp -R www-data storage bootstrap/cache
sudo chmod -R ug+rwx storage bootstrap/cache


: '---------------------------------
#sudo chmod -R 775 /var/www/tigrou.site/storage
#sudo chmod -R 775 /var/www/tigrou.site/bootstrap/cache

OU

## Faites de votre serveur Web le propriétaire des fichiers

sudo chown -R www-data:www-data /var/www/tigrou.site

# Ajoutez-vous au groupe d utilisateurs du serveur Web
sudo usermod -a -G www-data tigrou

sudo find /var/www/tigrou.site -type f -exec chmod 644 {} \;
sudo find /var/www/tigrou.site -type d -exec chmod 755 {} \;
---------------------------------'


printf "\nLaravel cleaning test in progress...\n"
sleep 2

php artisan route:clear; php artisan config:clear; php artisan config:cache; php artisan cache:clear
php artisan optimize:clear

printf "\nComposer Optimization...\n"
sleep 2

composer dump-autoload -o

printf "\nCopy/paste the following for the creation of the virtual host of \""$projectName"\" please :\n\n"

printf "\nCopy with Ctrl + Shift + C, then paste with Ctrl + Shift + V\n\n"

printf "<VirtualHost *:80>
    DocumentRoot /var/www/$projectName/public
    ServerName $projectName
    ServerAlias www.$projectName
    ServerAdmin webmaster@$projectName

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory /var/www/$projectName/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>\n\n"

while true; do
	read -p "Press Y to continue." cnt3
	case $cnt3 in
		[Yy]* ) break;;
		* ) printf "Please press Y to continue.\n";;
	esac
done

sudo nano /etc/apache2/sites-available/$projectName.conf

: '# Edit "Directory /var/www" AllowOverride All
# At the end, add ServerName 127.0.0.1, Apache error AH00558
printf "Edit \"Directory /var/www\" AllowOverride All\n"
printf "At the end, add ServerName 127.0.0.1, Apache error AH00558\n"
printf $DIVIDER

sudo nano /etc/apache2/apache2.conf'

printf "\nEnable the virtual host of \""$projectName"\" in progress...\n"
sleep 3

sudo a2ensite $projectName.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
#sudo a2dissite "$projectName".conf
sudo a2enmod rewrite

printf "\nAdd the localhost IP to the \""$projectName"\" site : 127.0.0.1 "$projectName"\n"

while true; do
	read -p "Press Y to continue." cnt3
	case $cnt3 in
		[Yy]* ) break;;
		* ) printf "Please press Y to continue.\n";;
	esac
done

sudo nano /etc/hosts
sudo systemctl restart apache2

# The End
printf "\nCongratulations, the script execution is complete! The \""$projectName"\" site is functional. Click on the link to launch the site.
.\n"
printf "http://"$projectName" (Ctrl + clic)\n\n\n"
read -p "Press ENTER to continue"
exit
