# Zorin-preseed
This repository has every file which is needed to make a preseeded installation of the Zorin OS 15.x

## Directory "files"
This directory will be copied to the */home/* directory on the target system. This can be used to make changes on the target system after the installation.

## File "ks.preseed"
This file gives the commands to Ubiquity for the preseeded installation.

## File "er.preseed"
This file is nearly identical to the file *ks.preseed*. There is only one additional command. The command executes the bash-script "erase.sh". It is executed before the partitioning.

## File "ersus.preseed"
This file is nearly identical to the file *er.preseed*. There is only one additional command. The command executes the bash-script "erase_sus.sh". It is executed before the partitioning.

## File "ksap.preseed"
This file is similar to *ks.preseed* but copies scripts at the end of the installation to the Desktop.

## File "erap.preseed"
This file is similar to *er.preseed* but copies scripts at the end of the installation to the Desktop.

## File "erapsus.preseed"
This file is similar to *ersus.preseed* but copies scripts at the end of the installation to the Desktop.

## File "erase.sh"
This file is a bash script, which searches for memory devices and excecutes the *hpdarm.sh* script for each of them. Only the last device is excluded, because this is mostly the install medium.
Because the livesystem, which makes the installation, has the most memory devices declared as frozen, the script suspends the computer automatically. It must be "waked up" manually by pressing the power button after the screen turns black.

## File "erase_sus.sh"
This file is the same as *erase.sh*. But the suspend of the computer is removed. This is due to the problem that some old computers aren't unable to suspend and reawaken.

### File "hpdarm.sh"
This file is a bash script, which erases a memory device. It use *hpdarm*. If it fails, it uses *dd* to overwrite the device with random numbers.

## File "menuentries.cfg"
This file is found in the directory *isolinux* of the original image. It is used to generate the bootmenu for the legacy boot. Every boot entry has the Ubiquity removed. The installation will be started from the livesystem.

## File "locale"
This file contains the localization of the system. It is copied from a manually installed system. The presseded installation will copy it to the directory */etc/default*. In a single user system this will set the localisation.
At the moment a copy of this file exists in the directory *files* and will be copied a second time through the personalisation step in the installed system.

## File "grub.cfg"
This file is found in the directory *boot/grub* of the original image. It is used to generate the bootmenu for the EFI boot. The first half of the file is for the visual expression and can be ignored. The second part is similar to *menuentries.cfg* and has the same parameters. Every bootentry has the Ubiquity removed. The installation will be started from the live system.

## File "kamera.sh"
Some Macbooks have problems with the camera-driver. This script reloads a free driver from github and sets it up.

## File "kamera.reload.sh"
This script is a reduced version of "script.sh". This is for times when the kernel is reinstalled due to the updates. This reloads the driver and recompile it.

## Workflow to create an preseeded image

### only the preseeding
1. To modify an existing image, you have to mount the existing image with 'sudo mount -o loop image.img mnt' and copy everything to the root directory of the mounted image, or an existing directory as mentioned above.
2. Now it is possible to make changes to the files as required.
3. With the following command you can create a *.iso* file from the working directory. 

```
mkisofs -D -r -V "UNATTENDED_ZORIN" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o unattanded-Zorin.iso iso
```

### Full
If there should be additional packages installed, the file steps.txt has the commands to do so.

## Workflow of the installation
1. Boot from the boot device.
2. Select the right option. There are four preseeded option and two backup options:
   1. preseeded installation without erasing of the memory devices.
   2. preseeded installation with erasing of the memory devices.
   3. preseeded installation with erasing of the memory devices without suspend.
   4. preseeded installation without erasing of the memory devices for Apple.
   5. preseeded installation with erasing of the memory devices for Apple.
   6. preseeded installation with erasing of the memory devices without suspend for Apple.

## Known issues
- The installation isn't fully unattended. Because of an unknown reason this is not possible. There must be a minimum one command uncommented.
- The computer restarts directly after the installation. So if the boot priority of the USB device is higher than the boot priority of the HDD, the computer could end up in an endless loop of installations. At the moment the option to continue the installation will be shown, if there are other installed operating systems.
- The language and the keyboard layout are set to english and en_US. These things are individualized after the installation is finished. 
