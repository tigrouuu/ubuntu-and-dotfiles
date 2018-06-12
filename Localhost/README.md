# Page d'accueil pour Localhost

Cette page d'accueil pour **Localhost** répertorie automatiquement les dossiers et fournit des liens vers vos sites locaux.

## Installation

Si vous avez suivi toute l'installation d'un serveur [LAMP](https://github.com/tigrouuu/archlinux-and-dotfiles/blob/master/LAMP.md), vous devriez avoir un Virtual Host avec pour adresse [http://code.local](http://code.local) pointant sur **/srv/http**.

[Télécharger](https://github.com/tigrouuu/archlinux-and-dotfiles.git) ce répertoire, l'extraire et copier tout ce qui se trouve dans le dossier `Localhost` à l'exception du fichier README.md dans **/srv/hhtp**. Vous devez également créer deux dossiers : **Code** et **Folders**.

**Code** est le dossier qui sera listé sur la page d'accueil lorsque vous irez sur [http://code.local](http://code.local).

**Folders** est un dossier où vous pouvez tout mettre, permettant de ne pas être listé sur la page d'accueil.

La structure de votre dossier **/srv/http** doit ressembler à la capture ci-dessous.

![alt text](https://raw.githubusercontent.com/tigrouuu/archlinux-and-dotfiles/master/Screenshots/Capture%20d%E2%80%99%C3%A9cran_2018-06-06_17-50-47.png)

Maintenant, vous pouvez éditer le fichier `config.php` dans le dossier `Localhomepage`.

Enjoy !

## P.S

Bien entendu, ceci marche pour Windows, Mac et toutes les distributions Linux ! Il faut seulement mettre tout ce qui se trouve dans le dossier **Localhost** de ce répertoire à la racine de votre dossier où **Apache** a accès.

## Note

This Localhomepage is a fork of : [cmall/LocalHomePage](https://github.com/cmall/LocalHomePage)

I modified his script :
* To add links using laravel
* To create a better documentation to understand how the script works
* To change the whole structure of the folder
