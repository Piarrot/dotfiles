yay --noconfirm -Syu --needed xorg numlockx \
    bspwm sxhkd rofi trash-cli thunar \
    lightdm lightdm-webkit-theme-litarvan light-locker

sudo cp ./templates/lightdm.conf /etc/lightdm/lightdm.conf
sudo cp ./templates/lightdm-webkit2.greeter.conf /etc/lightdm/lightdm-webkit2.greeter.conf

sudo systemctl enable lightdm

stow bspwm

#Terminal
yay --noconfirm -S --needed alacritty nerd-fonts-complete 
stow alacritty

#Ranger
yay --noconfirm -S --needed ranger
git clone https://github.com/alexanderjeurissen/ranger_devicons ~/.config/ranger/plugins/ranger_devicons
