# Linux Apache MariaDB PHP

Petit mémo personnel pour installer un [LAMP](https://doc.ubuntu-fr.org/lamp) rapidement !

### Sommaire

- Apache
- MariaDB
- PHP
- Adminer
- Virtual Host

> Pour ouvrir un fichier, j'utilise **Visual Studio Code** pour sortir du **Terminal**. Si vous ne l'avez pas, utilisez autre chose comme nano, vim etc.

Avant tout :

`$ sudo apt-get clean; sudo apt-get autoclean; sudo apt-get autoremove; sudo apt-get update; sudo apt-get upgrade`

## Apache

Installer Apache :

`$ sudo apt install apache2`

Ajouter Apache en liste blanche pour le parefeu **ufw** :

`$ sudo ufw allow in "Apache"`

## MariaDB

Installer le gestionnaire de base de données MariaDB, remplaçant de MySQL :

`$ sudo apt install mariadb-server`

Sécuriser l'installation de MySQL après le démarrage du service :

`$ sudo mysql_secure_installation`

Configurer MySQL en vous connectant en **root** : 

`$ sudo mysql -u root -p`(\q pour quitter)

## PHP

Installer PHP :

`$ sudo apt install php libapache2-mod-php php-mysql`
`$ sudo apt install php-curl php-gd php-intl php-json php-mbstring php-xml php-zip`

Vérifier que PHP soit bien à la version 7.4.* :

`$ php -v`

Ouvrez **Atom** pour créer le fichier **phpinfo.php**

`$ sudo nano /var/www/html/phpinfo.php`

```php
<?php phpinfo(); ?>
```

Tester la page en allant sur [Localhost/phpinfo.php](http://localhost/phpinfo.php).

## Adminer

Installer Adminer avec le fichier php.

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/httpd.conf`

Tester la page en allant sur [Localhost/adminer](http://localhost/adminer).

## Virtual Host

Rendre accessible le dossier **/srv/http** au groupe **http** :

`sudo chgrp --recursive http /srv/http`

`sudo chmod --recursive g+w /srv/http`

Ajouter l'utilisateur au groupe **http** :

`sudo usermod -a -G http tigrou`

Vérifier que le groupe **http** est bien présent :

`id tigrou`

Redémarrer la session, puis lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/hosts`

```
#
# /etc/hosts: static lookup table for host names
#

#<ip-address>   <hostname.domain.org>   <hostname>
127.0.0.1       localhost.localdomain   localhost
::1             localhost.localdomain   localhost
127.0.0.1       code.local              code.local
::1             code.local              code.local

# End of file
```

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/httpd.conf`

Décommenter : `Include conf/extra/httpd-vhosts.conf`
Ajouter à la fin : `ServerName code.local:80` (évite l'erreur AH00558)

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/extra/httpd-vhosts.conf`

```
<VirtualHost *:80>
    DocumentRoot "/srv/http/"
    ServerName http://code.local
    ServerAlias http://www.code.local
    ErrorLog /var/log/httpd/code.local.error.log
    CustomLog /var/log/httpd/code.local.access.log common

    <Directory "/srv/http/">
       Require all granted
    </Directory>
</VirtualHost>

```

Redémarrer le service Apache pour prendre en compte toutes les modifications :

`$ sudo systemctl restart httpd.service`

Puis vérifier que tout fonctionne bien :

`apachectl configtest`

Tester la page sur [code.local](http://code.local).

## Autres

Installer (AUR ou pas) :
- composer
- gulp
- koala
- [MailDev](http://danfarrelly.nyc/MailDev/)
- openssh
- php-gd
- php-cs-fixer
- phpunit
- ruby
- sassc
- xdebug (mettre dans **php.ini** `zend_extension="/usr/lib/php/modules/xdebug.so"`, puis **apacheR** et **php -m** dans le terminal)
