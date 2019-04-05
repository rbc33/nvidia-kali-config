# nvidia-kali-config
install and config nvidia drivers on asus GL552vw with kali linux

this script automatize the inicial configuration of a kali new installation:
    add kali repositories and update the system
    disables nouveau
    install and configure nvidia drivers

you can't login normally so you have to edit the grub adding nouveau.modeset=0 and then press F10 or pres ctrl+alt+F2 at login screen to login from terminal

go to the path of the archive nvidia.sh

to run the script execute froom root user $ sh ./nvidia.sh
