@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
REM You'll want to search your local Windows filesystem for a file called mkisofs.exe, and set the path to it below
SET "mkisofs_path=D:\temp\win10-upgrade-related\old-c-drive\Program Files (x86)\Video tools\DVDAuthorGUI\bin"
REM This is a helper script for Windows users
REM Note when extracting the Zorin ISO, mount the image using Windows Explorer native mounting. Extracting with 7-zip gave a payload error with Zorin-OS-15.3-Lite-64-bit.iso.
REM Create a folder tree like below, extract the ISO image contents to 'ISO' and clone this Github repo to 'Zorin-preseed'
REM Run this script from D:\Zorin
REM Folder tree:
REM D:\Zorin
REM ├───ISO
REM └───Zorin-preseed
CD ..
IF NOT EXIST ISO\files MD ISO\files
COPY /Y /V Zorin-preseed\files ISO\files
COPY /Y /V Zorin-preseed\*.preseed ISO
COPY /Y /V Zorin-preseed\*.sh ISO
COPY /Y /V Zorin-preseed\locale ISO
COPY /Y /V Zorin-preseed\menuentries.cfg ISO\isolinux
COPY /Y /V Zorin-preseed\grub.cfg ISO\boot\grub
SET _DATESTRING=!DATE:~0,2!!DATE:~3,2!!DATE:~6,4!
SET _TIMESTRING=!TIME:~0,2!!TIME:~3,2!
SET _TIMESTRING=!_TIMESTRING: =0!
"%mkisofs_path%\mkisofs" -D -r -V "UNATTENDED_ZORIN" -duplicates-once -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o unattanded-Zorin-!_DATESTRING!_!_TIMESTRING!.iso ISO