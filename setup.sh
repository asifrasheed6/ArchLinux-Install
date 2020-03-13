#!/bin/bash
echo "     
                 ##
                ####
               ######
              ########
             ##########
            ############
           ##############
          ################
         ##################
        ####################
       ######################
      #########      #########
     ##########      ##########
    ###########      ###########
   ##########          ##########
  #######                  #######
 ####                          ####
###                              ###
                     "
echo "Setting up ArchLinux..."

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
echo "Setting up root user..."
passwd
read -p "Enter new username:" user
useradd -m -G wheel $user
passwd $user
pacman -S sudo
cd /

if test -f "/etc/sudoers.pacnew"; then
    $f_sudo = "/etc/sudoers.pacnew"
else
    $f_sudo = "/etc/sudoers"
fi

cp $f_sudo /etc/sudoers.bak
sed '82c\
%wheel    ALL=(ALL)   ALL' /etc/sudoers.bak > $f_sudo
cd ..

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

# Network Manager
systemctl enable NetworkManager.service

# Finishing up
echo "The Setup will install Firefox, Python3, Geany, GCC, Make and Terminal by default"
read -p "Please enter all the extra package that you wish to install (default: None): " packages
pacman -S firefox python3 geany gcc make qterminal $packages

echo "Setup Complete!, You may restart the machine!"
