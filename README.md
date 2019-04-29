# nvidia-kali-config
install and config nvidia drivers on asus GL552vw with Debian, Ubuntu and Kali linux

this script automatize the inicial configuration of a new installation:
    add non-free and contrib repositories and update 
    disables nouveau
    install and configure nvidia drivers

you can't login normally so you have to edit the grub adding nouveau.modeset=0 and then press F10 or pres ctrl+alt+F2 at login screen to login from terminal

go to the path of the archive nvidia.sh 

to be able to execute the file execute as root $ chmod +x ./nvidia.sh

to run the script execute froom root user $ ./nvidia.sh
