pushd ..
rsync -a Zorin-preseed/files ISO
rsync -a Zorin-preseed/preseed ISO
rsync -a Zorin-preseed/shellscripts ISO
cp Zorin-preseed/locale ISO
cp Zorin-preseed/menuentries.cfg ISO/isolinux
cp Zorin-preseed/grub.cfg ISO/boot/grub
mkisofs -D -r -V "UNATTENDED_ZORIN" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o unattended-Zorin.iso ISO
isohybrid unattended-Zorin.iso # make ISO bootable
popd
