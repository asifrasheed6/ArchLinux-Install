#!/bin/bash
echo "        	  ##
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
 ###                              ###"
echo "Install Arch Linux, written by Asif Rasheed"
echo "Please enter your root directory: "
read -r rdir
echo "Please enter your efi directory: "
read -r efi

cd ..

# Creating filesystem
mkfs.fat -F32 $efi
mkfs.ext4 $rdir

# Selecting Mirror
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

# Installing Arch Linux
mount $rdir /mnt
pacstrap /mnt base linux linux-firmware vim nano

# Configuring install
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
timedatectl set-timezone Asia/Dubai

# Setting Locale
locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8

# Network Configuration
echo myarch > /etc/hostname
touch /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "::1	localhost" >> /etc/hosts
echo "127.0.1.1	myarch" >> /etc/hosts

# User Accounts
echo "Setting up root user..."
passwd
echo "Enter username..."
read -r user
useradd -m $user
passwd $user

# Installing bootloader
pacman -S grub efibootmgr
mkdir /boot/efi
mount $efi /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# Desktop environment
pacman -S xorg xorg-server plasma sddm
systemctl enable sddm

# Finishing up
pacman -S firefox python3 git geany gcc make sudo qterminal

exit
shutdown -r now

