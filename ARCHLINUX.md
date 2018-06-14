# Installer Archlinux

![alt text](https://raw.githubusercontent.com/tigrouuu/archlinux-and-dotfiles/master/Screenshots/Capture%20d%E2%80%99%C3%A9cran_2018-05-20_13-11-15.png)

> Info ! L'installation qui suit utilise **Anarchy 1.0.0** avec des choix personnalisés, datant du **20/05/2018**.

L'installation d'Archlinux se fait via [Anarchy](https://anarchy-linux.org/), sur deux disques durs (SSD et HDD). Pour cela, nous allons utiliser Gparted. Démarrer le PC en UEFI boot (F2) [GParted Live CD](https://gparted.org/livecd.php).

## Partitions

Les tables de partitions doivent être en GPT ! (Périphérique > Créer une table de partitions > GPT)

Les partions sont les suivantes : 

| Hardrive | Partition | Système de fichiers | Taille | Drapeaux | Point de montage |
|----------|-----------|---------------------|--------|----------|------------------|
|    SSD   | /dev/sdc1 |        fat32        |  1Gio  | Boot,ESP |    /boot/efi     |
|          | /dev/sdc2 |        ext4         | Reste  |          |    /             |
|    HDD   | /dev/sdb1 |     linux-swap      |  4Gio  |          |                  |
|          | /dev/sdb2 |        ext4         | Reste  |          |    /home         |

![alt text](https://raw.githubusercontent.com/tigrouuu/archlinux-and-dotfiles/master/Screenshots/Capture%20d%E2%80%99%C3%A9cran_2018-05-20_13-32-36.png)

![alt text](https://raw.githubusercontent.com/tigrouuu/archlinux-and-dotfiles/master/Screenshots/Capture%20d%E2%80%99%C3%A9cran_2018-05-20_13-32-12.png)

Sauvegarder le tout et redémarrer en UEFI Anarchy (SSD).

## Anarchy

- Mettre le clavier en français : loqdkeys fr)pc (en qwerty, ce qui donne loadkeys fr-pc en azerty)
- Mettre à jour Anarchy : anarchy -u
- Lancer l'installation : anarchy

Le fuseau horaire est Europe/Paris, et le clavier est fr_FR.

Faites la partition en manuelle afin de terminer ce qui a été commencé via GParted.
Se référer au tableau ci-dessus afin d'indiquer les différents points de montage (/, /home, /boot/efi et swap).

Installer Anarchy-desktop-LTS et Anarchy-xfce.

Pas d'installation de logiciels complémentaires car il y a de nombreux conflits entre ce d'Anarchy et nos choix. Tout se fera après.

# AUR

`$ sudo nano /etc/pacman.conf`

```
[archlinuxfr] 
SigLevel = Never 
Server = http://repo.archlinux.fr/$arch 
```

`$ sudo pacman -Syu yaourt`

`$ yaourt -Syu`

## Package Manager AUR

Installer [Trizen](https://github.com/trizen/trizen) :

```
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
```

Installer meson :

`$ sudo pacman -S meson`

Installer vala (AUR) :

`trizen -S vala`

Installer [Pamac](https://gitlab.manjaro.org/applications/pamac)

Pour avoir Pamac sur le Tableau de bord : 
Menu > Ajouter ou supprimer des logiciels installés sur le système > (clic droit) > Ajouter au tableau de bord

## Autres

Lancer **Atom** pour modifier le fichier :

`$ sudo atom /etc/vconsole.conf`

```
KEYMAP=fr-latin9
FONT=lat9w-16
```

Dans `/etc/locale.conf`, vérifier qu'il y a bien `LANG=fr_FR.UTF-8` et `LC_COLLATE=C`.

Dans `/etc/locale.gen`, vérifier que `fr_FR.UTF-8 UTF-8` soit décommenté.
