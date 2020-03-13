# ArchLinux-Install
1. Create partition /dev/sda1: EFI partition and /dev/sda2: Root Location
2. wifi-menu and connect to wifi
3. pacman -Syy
4. pacman -S git
5. git clone https://github.com/asifrasheed6/ArchLinux-Install
6. mv /ArchLinux-Install/* /
7. sh install.sh

Warning: I wrote this script for my computer, might not work on yours. If you want to change the parition location, feel free to do that in the source code. Also the default desktop I'm installing is KDM plasma, feel free to change that in the source code before you install.
