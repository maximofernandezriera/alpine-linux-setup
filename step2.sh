#!/bin/ash

apk add curl socat nmap net-tools build-base setxkbmap sudo xrandr bash zsh dbus dbus-x11 sudo setup-xorg-base xfce4 xfce4-terminal lightdm dbus-x11
apk add open-vm-tools open-vm-tools-guestinfo open-vm-tools-deploypkg open-vm-tools-gtk
apk add lightdm-gtk-greeter i3wm i3status libxcb-dev i3lock xf86-video-vmware dmenu
apk add mesa-gl glib feh firefox-esr accountsservice openvpn
apk add docker docker-compose

# add user
adduser maximo
mkdir -p /home/maximo/wallpaper
mkdir -p /home/maximo/.config/i3

# user setup maximo
cp ./maximo/wallpaper/compass.jpg /home/maximo/wallpaper/compass.jpg
cp ./maximo/.config/i3/config /home/maximo/.config/i3/config
cp ./maximo/.profile /home/maximo/.profile
mkdir -p /home/maximo/.scripts
cp ./ibuetler/login-script.sh /home/maximo/.scripts/login-script.sh
chown -R ibuetler:maximo /home/maximo

# add maximo to sudoers
cat ./maximo/sudoers >> /etc/sudoers

# greeter background
echo "background=/home/maximo/wallpaper/compass.jpg" >> /etc/lightdm/lightdm-gtk-greeter.conf

# set background image in accountsservice
cp ./ibuetler/maximo /var/lib/AccountsService/users
chown root:root /var/lib/AccountsService/users/maximo

# add user to docker
addgroup maximo docker

# enable copy paste in vmware
chmod g+s /usr/bin/vmware-user-suid-wrapper

# give ibuetler write access to /opt dir
chown maximo:maximo /opt

# mkdir /opt/docker
mkdir -p /opt/docker
cp ./docker/* /opt/docker/
chown maximo:maximo /opt/docker


