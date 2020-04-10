# ArchLinux-Install
## Once you boot into ArchLinux using installation media: 
### Before you start
Create an EFI partition:
1. fdisk -l (find you drive from the list, it would be something like /dev/sda)
2. cfdisk /dev/sda (replace /dev/sda with your drive)
3. Create a 500 MB partition.
4. Select type and choose EFI System.
5. From the list on top, please note down your device locations like /dev/sda1 or /dev/sda2. (You need this during installation)

### Some definitions
Root Directory is the location of the parition where you are installing the os (how to find location? read the previous section). EFI Directory is the location of the efi partition you created. 

### To install Arch Linux:
1. wifi-menu
2. pacman -Syy
3. pacman -S git
4. git clone https://github.com/asifrasheed6/ArchLinux-Install --branch 0.1-rev3
5. cd ArchLinux-Install
6. sh install.sh

You could download the latest releases [as zip](https://github.com/asifrasheed6/ArchLinux-Install/archive/v0.1-rev3.zip) and [as tar.gz](https://github.com/asifrasheed6/ArchLinux-Install/archive/v0.1-rev3.tar.gz) or [find older releases](https://github.com/asifrasheed6/ArchLinux-Install/releases).

Feel free to [email me](mailto:asif@linuxmail.org) if you have any issues.

<b>Warning:</b> This is not an [official tutorial](https://wiki.archlinux.org/index.php/installation_guide).

<b>Note:</b> The desktop I'm installing is KDM plasma, feel free to change that in the source code before you install.
