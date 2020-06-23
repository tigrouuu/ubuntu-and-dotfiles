# Installer Ubuntu

![alt text](https://raw.githubusercontent.com/tigrouuu/ubuntu-and-dotfiles/master/Screenshots/terminal-gnome.png)

> Info ! L'installation qui suit date de **06/2020**.

L'installation d'Ubuntu se fait via une clé USB de 4Go en utilisant USB Creator (Créer un disque de démarrage) ou avec la ligne de commande suivante :
`sudo dd bs=4M status=progress if=Downloads/ubuntu-16.04-desktop-amd64.iso of=/dev/disk1`

L'installation se fera sur deux disques durs (SSD et HDD). Pour cela, nous allons utiliser Gparted. Démarrer le PC en UEFI boot (F2) [GParted Live CD](https://gparted.org/livecd.php).


## Partitions

Les tables de partitions doivent être en GPT ! (Périphérique > Créer une table de partitions > GPT)

Les partions sont les suivantes : 

| Hardrive | Partition | Système de fichiers | Taille | Drapeaux | Point de montage |
|----------|-----------|---------------------|--------|----------|------------------|
|    SSD   | /dev/sdc1 |        fat32        |  1Gio  | Boot,ESP |    /boot/efi     |
|          | /dev/sdc2 |        ext4         | Reste  |          |    /             |
|    HDD   | /dev/sda1 |     linux-swap      |  8Gio  |          |                  |
|          | /dev/sda2 |        ext4         | Reste  |          |    /home         |

![alt text](https://raw.githubusercontent.com/tigrouuu/ubuntu-and-dotfiles/master/Screenshots/gparted-sdc.png)

![alt text](https://raw.githubusercontent.com/tigrouuu/ubuntu-and-dotfiles/master/Screenshots/gparted-sda.png)

Sauvegarder le tout et redémarrer Ubuntu avec la clé USB en UEFI pour l'installer.
