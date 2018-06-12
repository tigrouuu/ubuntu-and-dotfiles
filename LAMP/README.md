# Linux Apache MariaDB PHP

Petit mémo personnel pour installer un [LAMP](https://wiki.archlinux.fr/LAMP) rapidement !

### Sommaire

- Apache
- MariaDB
- PHP
- Adminer
- Virtual Host

> Pour ouvrir un fichier, j'utilise **Atom** pour sortir du **Terminal**. Si vous ne l'avez pas, utilisez autre chose comme nano, vim etc.

## Apache

Installer Apache :

`$ sudo pacman -S apache`

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/httpd.conf`

Décommenter : `#LoadModule unique_id_module modules/mod_unique_id.so`

Démarrer le service Apache pour la session en cours :

`$ sudo systemctl start httpd`

Lancer automatiquement Apache lorsque vous démarrez votre PC :

`$ sudo systemctl enable httpd`

Ouvrez **Atom** pour créer le fichier **index.html**

`$ sudo atom /srv/http/index.html`

```html
<html>
 <title>Tigrou</title>
  <body>
   <h2>Welcome to Archlinux</h2>
  </body>
</html>
```

Tester la page en allant sur [Localhost](http://localhost).

## MariaDB

Installer le gestionnaire de base de données MariaDB, remplaçant de MySQL :

`$ sudo pacman -S mariadb`

Les tables devraient être mises en place :

`$ sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql`

Démarrer le service MySQL pour la session en cours :

`$ sudo systemctl start mysqld`

Lancer automatiquement MySQL lorsque vous démarrez votre PC :

`$ sudo systemctl enable mysqld`

`$ sudo systemctl status mysqld.service` (q pour quitter)

Sécuriser l'installation de MySQL après le démarrage du service :

`$ sudo mysql_secure_installation`

Configurer MySQL en vous connectant en **root** : 

`$ sudo mysql -u root -p`(\q pour quitter)

## PHP

Installer PHP :

`$ sudo pacman -S php php-apache`

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/httpd.conf`

Commenter : `LoadModule mpm_event_module modules/mod_mpm_event.so`
Décommenter : `LoadModule mpm_prefork_module modules/mod_mpm_prefork.so`

Ajouter à la fin des **LoadModule** :

LoadModule php7_module modules/libphp7.so
AddHandler php7-script php

Ajouter à la fin des **Includes** :

Include conf/extra/php7_module.conf

Ouvrez **Atom** pour créer le fichier **phpinfo.php**

`$ sudo nano /srv/http/phpinfo.php`

```php
<?php phpinfo(); ?>
```

Tester la page en allant sur [Localhost/phpinfo.php](http://localhost/phpinfo.php).

Configurer PHP en ouvrant **Atom** :

`$ sudo atom /etc/php/php.ini`

Modifier tout ce qui suit (ajouter, modifier, (dé)commenter) :

```ini
date.timezone = Europe/Paris

display_errors = On

extension=bz2
extension=gd
extension=mysqli
extension=pdo_mysql
extension=pdo_sqlite
```

Installer le paquet **sqlite** :

`$ sudo pacman -S sqlite`

Sur la page [Localhost/phpinfo.php](http://localhost/phpinfo.php), vérifier que **sqlite** est activé dans **PDO drivers**.

Redémarrer le service Apache pour prendre en compte toutes les modifications :

`$ sudo systemctl restart httpd.service`

Tester la page en allant sur [Localhost/phpinfo.php](http://localhost/phpinfo.php).

## Adminer

Installer Adminer avec AUR.

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/httpd.conf`

Ajouter à la fin des **Includes** :

`Include conf/extra/httpd-adminer.conf`

Redémarrer le service Apache pour prendre en compte toutes les modifications :

`$ sudo systemctl restart httpd.service`

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

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/httpd/conf/extra/httpd-vhosts.conf`

```
<VirtualHost *:80>
    DocumentRoot "/srv/http/code"
    ServerName code.local
    ServerAlias www.code.local
    ErrorLog /var/log/httpd/code.local.error.log
    CustomLog /var/log/httpd/code.local.access.log common

    <Directory "/srv/http/code">
       # Options FollowSymLinks
       # AllowOverride All
       # Order allow,deny
       # Allow from all
       Require all granted
    </Directory>
</VirtualHost>
```

Créer le dossier **code** dans **/srv/http**, puis vérifier que tout fonctionne bien :

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
- xdebug
