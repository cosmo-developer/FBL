@echo off
nasm -f bin mbr.S -o ./bin/mbr.bin
nasm -f bin space.S -o ./bin/space.bin
nasm -f bin kernel16.S -o ./bin/kernel16.bin
nasm -f bin loader.S -o ./bin/loader.bin

cat ./bin/mbr.bin ./bin/kernel16.bin ./bin/loader.bin > ./bin/bootloader.bin

dd if=./bin/bootloader.bin of=./build/bootloader.img

qemu-system-i386 -fda ./build/bootloader.img

@echo on
