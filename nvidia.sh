#!/usr/bin/env bash

#add kali repositories and upgrade

echo  '
    deb http://http.kali.org/kali kali-rolling main non-free contrib
    deb-src http://http.kali.org/kali kali-rolling main non-free contrib' >> /etc/apt/sources.list
apt update; apt upgrade

#disable nouveau

echo -e "blacklist nouveau\noptions nouveau modeset=0\nalias nouveau off" > /etc/modprobe.d/blacklist-nouveau.conf

update-initramfs -u

#install linux headers and nvidia-driver

apt -y install linux-headers-$(uname -r)
apt -y install nvidia-driver nvidia-xconfig
apt -y autoremove

#generate xorg with the nvidia's BusID

echo 'Section "ServerLayout"
    Identifier "layout"
    Screen 0 "nvidia"
    Inactive "intel"
EndSection

Section "Device"
    Identifier "nvidia"
    Driver "nvidia"' > /etc/X11/xorg.conf
echo '    BusID "'$(nvidia-xconfig --query-gpu-info | grep 'BusID : ' | cut -d ' ' -f6)'"'  >> /etc/X11/xorg.conf
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

echo '[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer' > /usr/share/gdm/greeter/autostart/optimus.desktop
echo '[Desktop Entry]
Type=Application
Name=Optimus
Exec=sh -c "xrandr --setprovideroutputsource modesetting NVIDIA-0; xrandr --auto"
NoDisplay=true
X-GNOME-Autostart-Phase=DisplayServer' > /etc/xdg/autostart/optimus.desktop

#install CUDA drivers

apt -y install ocl-icd-libopencl1 nvidia-cuda-toolkit

