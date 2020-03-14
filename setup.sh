#!/bin/bash
echo "Setting up ArchLinux..."
pacman -Syy

# Setting Locale
timedatectl set-timezone Asia/Dubai # Default Location: Dubai
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8

# Network Configuration
echo myarch > /etc/hostname
touch /etc/hosts
echo "127.0.0.1    localhost" >> /etc/hosts
echo "::1    localhost" >> /etc/hosts
echo "127.0.1.1    myarch" >> /etc/hosts

# User Accounts
clear
echo "Setting up root user..."
passwd

user = "user"
read -p "Enter new username (default: user):" user
useradd -m -G wheel $user
passwd $user
pacman -S sudo

cp /etc/sudoers /etc/sudoers.bak
sed '82c\
%wheel    ALL=(ALL)   ALL
' /etc/sudoers.bak > /etc/sudoers

# Installing bootloader
read -p "Please enter your efi directory: " efi
pacman -S grub efibootmgr
mkdir /boot/efi
mount $efi /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# Desktop environment setup
pacman -S xorg xorg-server plasma sddm
systemctl enable sddm

tar xvf plasma-chili.tar -C /usr/share/sddm/themes

cp /usr/lib/sddm/sddm.conf.d/default.conf /usr/lib/sddm/sddm.conf.d/default.bak
sed '33c\
Current=plasma-chili
' /usr/lib/sddm/sddm.conf.d/default.bak > /usr/lib/sddm/sddm.conf.d/default.conf

# Network Manager
systemctl enable NetworkManager.service

# Finishing up
clear
echo "The Setup will install Firefox, Python3, Geany, GCC, Make and Terminal by default"
read -p "Please enter all the extra package that you wish to install (default: None): " packages
pacman -S firefox python3 geany gcc make dolphin alacritty base-devel $packages
systemctl set-default graphical.target

rm -rf plasma-chili.tar
rm -rf $0
