@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
REM
REM This is a helper script for Microsoft Windows users
REM
REM First you'll want to search your local filesystem for a file called mkisofs.exe, and SET the path to it below
REM Hint: 'where /R \ mkisofs.exe' might be useful
REM If you can't find it, download it as part of the cdrtools package from http://smithii.com/cdrtools
SET "mkisofs_path=D:\Zorin\cdrtools-latest"
REM
REM The flow goes like this:
REM 1/ Mount Zorin ISO (do manually in Explorer, double-click Zorin ISO file)
REM 2/ Copy all ISO files from mounted drive to temporary 'ISO' folder (do manually, CTRL+A, CTRL+C, switch folder, CTRL+V)
REM 3/ Copy Github files to appropriate paths in temporary 'ISO' folder (this script does this bit)
REM 4/ Build new ISO file from temporary 'ISO' folder contents (this script does this bit)
REM
REM Note when extracting the Zorin ISO, mount the image using Windows Explorer native mounting. 
REM Extracting with 7-zip gave a payload error with Zorin-OS-15.3-Lite-64-bit.iso.
REM Create a folder tree like below, extract the ISO image contents to the 'ISO' folder and clone this Github repo to the 'Zorin-preseed' folder (or move it from where it is now, to that folder)
REM
REM D:\Zorin
REM ├───ISO (the contents of the ISO file as copied over by you)
REM └───Zorin-preseed (the Github repo)
REM
REM Once you're ready, open a command prompt, change directory to the 'Zorin-preseed' folder, and type copyfilesmakeiso.cmd (the name of this script)

PUSHD ..
ECHO Copying Github files
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
ECHO Building new ISO file
"%mkisofs_path%\mkisofs.exe" -D -r -V "UNATTENDED_ZORIN" -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o unattended-Zorin-!_DATESTRING!_!_TIMESTRING!.iso ISO
POPD