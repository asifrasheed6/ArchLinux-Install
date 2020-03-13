# ArchLinux-Install
### Before you start
If you have a UEFI system, you must create an EFI partition.
1. fdisk -l (find you drive from the list, it would be something like /dev/sda)
2. cfdisk /dev/sda (replace /dev/sda with your drive)
3. Create a 500 MB partition.
4. Select type and choose EFI System.
5. From the list on top, please note down your device locations like /dev/sda1 or /dev/sda2. (You need this during installation)
### From the ArchLinux Live ISO:
1. wifi-menu
2. pacman -Syy
3. pacman -S git
4. git clone https://github.com/asifrasheed6/ArchLinux-Install
5. cd ArchLinux-Install
6. sh install.sh

<b>Note:</b> The desktop I'm installing is KDM plasma, feel free to change that in the source code before you install.
