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
echo "Install Arch Linux, written by Asif Rasheed"

read -p "Please enter your keyboard layout (default: us): " layout
if $layout = "" then layout = "us" fi
loadkeys $layout

read -p "Please enter your root directory: " rdir
read -p "Please enter your efi directory: " efi

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
mv setup.sh /mnt
arch-chroot /mnt sh setup.sh $efi $layout

umount -R /mnt
shutdown -r now
