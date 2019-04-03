#!/usr/bin/env bash

#add kali repositories and upgrade

echo  '
    deb http://http.kali.org/kali kali-rolling main non-free contrib
    deb-src http://http.kali.org/kali kali-rolling main non-free contrib' > etc/apt/sources.list
apt update; apt upgrade

#disable nouveau

echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf

update-initramfs -u

#install linux headers and nvidia-driver

apt install linux-headers-$(uname -r)
apt install nvidia-driver nvidia-xconfig
apt autoremove

#generate xorg with the nvidia's BusID

echo 'Section "ServerLayout"
    Identifier "layout"
    Screen 0 "nvidia"
    Inactive "intel"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"' > /etc/X11/xorg.conf
echo '  BusID "'$(nvidia-xconfig --query-gpu-info | grep 'BusID : ' | cut -d ' ' -f6)'"'  >> /etc/X11/xorg.conf
echo 'EndSection

Section "Screen"
    Identifier "nvidia"
    Device "nvidia"
    Option "AllowEmptyInitialConfiguration"
EndSection

Section "Device"
    Identifier "intel"
    Driver "modesetting"
EndSection

Section "Screen"
    Identifier "intel"
    Device "intel"
EndSection' >> /etc/X11/xorg.conf

#install CUDA drivers

apt install ocl-icd-libopencl1 nvidia-cuda-toolkit
