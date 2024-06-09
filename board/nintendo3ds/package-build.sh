#!/bin/bash

# Set target folder (relative with no spaces)
targetfolder="./output/images/sdcard-content"

echo "Creating target folders..."
mkdir -p $targetfolder/linux

echo "Downloading bootloader..."
wget -O $targetfolder/boot-linux.firm "https://github.com/linux-3ds/firm_linux_loader/releases/download/latest/firm_linux_loader.firm"

#echo "Downloading ARM9 firmware..."
#wget -O $targetfolder/linux/arm9linuxfw.bin "https://github.com/linux-3ds/arm9linuxfw/releases/download/latest/arm9linuxfw.bin"
echo "Copying ARM9 firmware..."
cp -v ./board/nintendo3ds/arm9linuxfw.bin $targetfolder/linux

echo "Copying device trees..."
cp -v ./output/build/linux-custom/arch/arm/boot/dts/nintendo3ds_ctr.dtb ./output/build/linux-custom/arch/arm/boot/dts/nintendo3ds_ktr.dtb $targetfolder/linux

echo "Copying kernel..."
cp -v ./output/images/zImage $targetfolder/linux

exit 0
