#!/bin/bash

mkdir -p development/linux
pushd development/linux
git clone https://aur.archlinux.org/yay.git 
cd yay
makepkg -si --noconfirm
popd

yay -Y --devel --save