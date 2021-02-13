# Configurer Ubuntu 20.10

![alt text](https://raw.githubusercontent.com/tigrouuu/ubuntu-and-dotfiles/master/Screenshots/terminal-gnome.png)

> Info ! L'installation qui suit date de **février 2021**.

## Sommaire :

1. Sauvegarder, Exporter
2. Formater Ubuntu
3. Configurer la base
4. Installer les logiciels
5. Configurations
6. LAMP, Composer, VirtualHost
7. Conclusion
8. Autres docs

## 1. Sauvegarder, Exporter

### 1. Trier les dossiers

Supprimer, modifier le nom des fichiers ou dossiers et déplacer dans les bons dossiers.

### 2. Sauvegarder config, extensions, favoris

* Favoris et extensions Google Chrome
* Exporter URL de OneTab
* Extensions et préférence de VSCode (settings.json)
* .bashrc, .bash_aliases, .bash_prompt
* .gitconfig
* fichier .conf d’apache (/etc/apache2/sites-available/)

### 3. Faire des photos

* dock pour logiciels en favoris
* logiciels installés
* configurations pour certains logiciels (remmina, filezilla)

### 4. Transférer

Copier l’ensemble sur un disque dur externe.

## 2. Formater Ubuntu

### 1. Télécharger

Sur le site officiel de [Ubuntu](https://ubuntu.com/download/desktop), télécharger la dernière version (actuellement 20.10).

### 2. Créer une clé USB

Prendre une clé USB  de 4Go minimum.

Avec gParted, formater la clé : démonter la clé, créer une table de partition gpt, nouvelle partition fat32.

Lancer le logiciel « Créateur de disque de démarrage ». Puis sélectionnez le fichier.iso, choisissez la clé USB et exécuter.

### 3. Démarrer sur la clé

Redémarrez le PC et appuyez sur **F2** au démarrage pour accéder au BIOS. Dans celui-ci, mettre USB uefi au début, puis **F10** pour sauvegarder et redémarrer.

### 4. Installer Ubuntu

Suivez l’installation de Ubuntu. Pour une installation propre, choisissez de configurer vous-même les disques durs :
| Hardrive | Partition | Système de fichiers | Taille | Drapeaux | Point de montage |
|----------|-----------|---------------------|--------|----------|------------------|
|    SSD   | /dev/sdc1 |        fat32        |  1Gio  | Boot,ESP |    /boot/efi     |
|          | /dev/sdc2 |        ext4         | Reste  |          |    /             |
|    HDD   | /dev/sda1 |     linux-swap      |  8Gio  |          |                  |
|          | /dev/sda2 |        ext4         | Reste  |          |    /home         |
|    HDD   | /dev/sdb  |        ext4         | Tout   |          |                  |

## 3. Configurer la base

Configuration de l’affichage : changer la résolution de l’écran (1920x1080, 16:9, ajuster pour une TV)

Mettre à jour le système :

`sudo apt-get update && sudo apt-get upgrade`

Gnome Shell :

`sudo apt-get install gnome-tweaks gnome-tweak-tool gnome-shell-extension-prefs`

Installation des packages importants :

`sudo apt-get install build-essential fakeroot checkinstall ubuntu-restricted-extras curl git gufw unzip wget`

Enlever les messages d’erreur (rapport) :

`sudo apt remove apport apport-gtk`

Installer Snap :
```
sudo apt install snapd
sudo snap install snap-store
```


## 4. Installer les logiciels

### 1. Snap

Sur le site [Snapcraft.io](https://snapcraft.io/store) : discord, gimp, postman, signal-desktop, slack, spotify, termius-app, vlc, vscode.

`sudo snap install node --channel=15/stable –classic`

### 2. Terminal

```
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install filezilla google-chrome-stable gparted mysql-workbench screenfetch transmission
```

## 5. Configurations

### 1. VSCode

Sauvegarder les extensions :

`code --list-extensions >> vs_code_extensions_list.txt`

Dossier pour importer les préférences : `~/.config/Code/User/settings.json`

Installer une font spécifique :

`sudo apt install fonts-firacode`

### 2. Google Chrome

Supprimer la demande du mot de passe du trousseau de clés :
```
sudo gedit /usr/share/applications/google-chrome.desktop
Exec=/usr/bin/google-chrome-stable --password-store=basic %U
cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications
```

Redémarrer le PC. Lorsqu’on lance Google Chrome, laissez les champs vides pour le trousseau.

### 3. Filezilla

Ajouter une config FTP pour le site :
* ftp
* port 22
* username
* password

### 4. Remmina

Créer les clés public et private :

`ssh-keygen -t rsa  -b 4096 -C "mon-mail@gmail.com"`

Enregistrer connexion SSH dans Remmina :
* serveur :
* nom d’utilisateur :
* mdp :
* type d’authentification : mdp

### 5. Dock

Ajouter le thème icône « Papirus » :
```
sudo add-apt-repository ppa:papirus/papirus
sudo apt install papirus-icon-theme
```

Ajouter le thème gtk [Qogir dark](https://www.gnome-look.org/p/1230631/#files-panel). Créer le dossier `~/.themes` et extraire `Qogir dark`.

Via « Ajustement » (gnome-tweak), changer le thème et les icônes.

### 6. Bash

Ouvrir le fichier .bashrc et le modifier avec la sauvegarde faite auparavant.
Ajouter les fichiers `.bash_aliases` et `.bash_prompt` dans `/home`.

Idem pour le fichier `.gitconfig`.

`source ~/.bashrc`

Configurer les préférences dans Terminal (nouveau profil, couleur solidarized dark)

## 6. LAMP, Composer, VirtualHost

### 1. Apache

```
sudo apt update
sudo apt install apache2
```

Paramètre pour le pare-feu UFW :

```
sudo ufw app list
sudo ufw allow in "Apache"
sudo ufw status
```

Vérifier qu’Apache fonctionne : [http://localhost](http://localhost)

### 2. MySQL

```
sudo apt install mariadb-server
sudo mysql_secure_installation (touche entrée, N, Y plusieurs fois)
```

Tester MariaDB :
```
sudo systemctl status mariadb, sinon sudo systemctl start mariadb
sudo service mariadb  status
```

### 3. PHP

`sudo apt install php libapache2-mod-php php-mysql`

Tester la version : `php -v`

```
sudo apt install php-cli php-curl php-gd php-intl php-json php-mbstring php-xml php-zip php-xdebug
sudo phpenmod mbstring
```

`sudo service apache2 restart`

### 4. VirtualHosts

Changer le dossier par défaut d’Apache en créant un dossier dans `/home` :
```
mkdir /home/tigrou/Sites
chown www-data /home/tigrou/Sites -Rf
sudo chmod 775 -R /home/tigrou/Sites
```

Modifier la directive DocumentRoot par `/home/tigrou/Sites` :

`sudo nano /etc/apache2/sites-available/000-default.conf`

Ouvrir le fichier suivant :
`sudo nano /etc/apache2/apache2.conf`

Coller ceci :
```
<Directory /home/tigrou/Sites>
Options Indexes FollowSymLinks
AllowOverride None
Require all granted
</Directory>
```

Et mettre à la fin :

`ServerName 127.0.0.1`

`sudo service apache2 restart`

### 5. Tester PHP dans /home/tigrou/Sites

Créer le fichier suivant :

`nano /home/tigrou/Sites/info.php`

Mettre dedans :

`<?php phpinfo(); ?>`

Vérifier que PHP fonctionne : [http://localhost/info.php](http://localhost/info.php)

Puis supprimer :

`rm /home/tigrou/Sites/info.php`

### 6. PHPmyAdmin

Installer phpmyadmin :
```
sudo apt install phpmyadmin
sudo service apache2 restart
```

Créer un nouvel utilisateur pour accéder à phpmyadmin :
```
sudo mysql
CREATE USER 'tigrou'@'localhost' IDENTIFIED BY 'tigrou';
GRANT ALL ON *.* TO 'tigrou'@'localhost';
FLUSH PRIVILEGES;
```

Tester via : [http://localhost/phpmyadmin](http://localhost/phpmyadmin)

### 7. Composer

```
wget -O composer-setup.php https://getcomposer.org/installer
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
```

Supprimer `~/composer-setup.php`

Vérifier dans Terminal : `composer`

### 8. Nouveau domaine Host

Créer un nouveau fichier conf pour apache :

`sudo nano /etc/apache2/sites-available/domain.conf`

Mettre dedans :
```
<VirtualHost *:80>
    <Directory /home/tigrou/Sites/domain/public>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ServerAdmin admin@domain
    ServerName domain
    ServerAlias www.domain
    DocumentRoot /home/tigrou/Sites/domain/public
    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

```
sudo a2ensite domain
sudo a2dissite 000-default
sudo apache2ctl configtest
```

Ajouter 127.0.0.1 domain dans :

`sudo nano /etc/hosts`

`sudo systemctl reload apache2`

Créer le fichier suivant :

`nano /home/tigrou/Sites/domain/index.html`

Mettre dedans :
```
<h1>Ça fonctionne !</h1>
<p>Cette page marche avec le domaine : <strong>domain</strong>.</p>
```

Vérifier que le virtual host fonctionne : [http://domain](http://domain)

**Optionnel :** une page de maintenance est possible avec index.html, qui sera prioritaire sur index.php !!

`sudo nano /etc/apache2/mods-enabled/dir.conf`

Mettre dedans :
```
<IfModule mod_dir.c>
        DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IfModule>
```

`sudo systemctl reload apache2`

(Inutile avec Laravel : `php artisan down`)

Pour finir : ouvrir le fichier `.bash_aliases` pour modifier les chemins vers les nouveaux sites (`/home/tigrou/Sites`).

## 7. Conclusion

Tester les versions pour vérifier que tout est fonctionnel :
```
php -v (actuellement 7.4.9)
node -v (actuellement 15.8.0)
npm -v (actuellement 7.5.1)
git --version (actuellement 2.27.0)
composer -V (actuellement 2.0.9)
laravel -V (actuellement 4.1.1)
```
