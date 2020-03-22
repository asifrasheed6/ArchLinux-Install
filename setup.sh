#!/bin/bash
# $0 refers to this script itself
# $1 refers to the first argument passed (in our case, from install.sh it is $EFI)
# $2 refers to the second argument passed (in our case, from install.sh it is $layout)
clear
echo "Setting up ArchLinux..."
pacman -Syy

# Setting Locale
read -p "Please enter your time zone (default: Asia/Dubai): " location

if test "$location" = ""
then
    timedatectl set-timezone "Asia/Dubai"
else
    timedatectl set-timezone $location
fi

locale-gen
echo LANG=en_GB.UTF-8 > /etc/locale.conf
export LANG=en_GB.UTF-8

echo "KEYMAP=$2" >> /etc/vconsole.conf

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

read -p "Enter new username (default: user):" user

# Adds a new user to wheel group
if test "$user" = ""
then
    useradd -m -G wheel user 
else
    useradd -m -G wheel $user
fi

passwd $user
pacman -S sudo # Installs sudo

cp /etc/sudoers /etc/sudoers.bak
sed '82c\
%wheel    ALL=(ALL)   ALL
' /etc/sudoers.bak > /etc/sudoers # Give sudo permisson to wheel group

# Installing bootloader
pacman -S os-prober grub efibootmgr
os-prober
mkdir /boot/efi
mount $1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg

# Desktop environment setup
pacman -S xorg xorg-server plasma sddm git wget # Installs xorg, xorg-server, kde plasma, sddm, git and wget
systemctl enable sddm # Would enable SDDM in startup

git clone https://www.opencode.net/marianarlt/sddm-sugar-candy # Sugar Candy theme for SDDM, Made by Marian
mkdir /usr/share/sddm/themes/sugar-candy # Creates new theme folder
mv sddm-sugar-candy/* /usr/share/sddm/themes/sugar-candy # Moves the cloned to contents to the theme directory
rm -rf sddm-sugar-candy # Removes the empty directory

wget https://unsplash.com/photos/H7nMkBMgcNw/download # non-copyrighted wallpaper
mv download /usr/share/sddm/themes/sugar-candy/Backgrounds/wallpaper.jpg

# Modifies the sugar candy login screen
cp /usr/share/sddm/themes/sugar-candy/theme.conf /usr/share/sddm/themes/sugar-candy/theme.bak
sed '3c\
Background="Backgrounds/wallpaper.jpg"
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Sets new wallpaper for sugar candy

sed '21c\
PartialBlur="false"
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Removes Paritial Blur

sed '34c\
FormPosition="center"
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Moves the login form to center

sed '47c\
AccentColor="#FFFFFF"
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Sets the accent color as white

sed '53c\
OverrideLoginButtonTextColor="#000000"
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Sets the login button text color as black

sed '119c\
HeaderText=""
' /usr/share/sddm/themes/sugar-candy/theme.bak > /usr/share/sddm/themes/sugar-candy/theme.conf # Removes the Header Text 

cp /usr/lib/sddm/sddm.conf.d/default.conf /usr/lib/sddm/sddm.conf.d/default.bak
sed '33c\
Current=sugar-candy
' /usr/lib/sddm/sddm.conf.d/default.bak > /usr/lib/sddm/sddm.conf.d/default.conf # Sets Sugar Candy as the default SDDM theme

# lookandfeeltool -a 'org.kde.breezedark.desktop', KDE Plasma Breeze Dark Desktop, won't work for root
# Try to run the above code by yourself once you install the os, will fix it later in the installation

# Network Manager
systemctl enable NetworkManager.service # Would enable network manager in startup

# Finishing up
echo "The Setup will install VLC, Image View, Firefox, Python3, Geany, GCC, Make and Terminal by default"
read -p "Please enter all the extra package that you wish to install (default: None): " packages
pacman -S vlc viewnior firefox python3 python-pip geany gcc make dolphin alacritty base-devel xf86-video-vesa $packages
systemctl set-default graphical.target # Sets Graphical Target as default

rm -rf $0 # removes the script
