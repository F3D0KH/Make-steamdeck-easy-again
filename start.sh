#!/bin/bash
if [ "$(whoami)" != 'root' ]; then
    echo "Sorry, this script requires root. Please relaunch like that -> sudo ./start.sh"
    exit 1
fi
# Остальная часть скрипта
echo "The script is launched from root. Launch!"
echo "#############################################"
echo "#Tool to make your work on steamdeck easier!#"
echo "#                                           #"
echo "#             by F3D0KH                     #"
echo "#############################################"

echo "Choose your option:"
echo "1) Readonly disable                          2) Update all pkg"
echo "3) Fuck you pacman!(Switch SigLevel)         4) Install tailscale and try to login in"
echo "5) Download latest version zapret(linux)     6) start WG (if it already exist)"
echo "7) Download and make latest version curseforge"
echo "8) exit"
read answer
if [ "$answer" == 1 ]; then
    sudo steamos-readonly disable
fi
if [ "$answer" == 2 ]; then
    sudo pacman -Suy
fi
if [ "$answer" == 3 ]; then
    sudo sed -i '42s/.*/SigLevel = Never/' /etc/pacman.conf
fi
if [ "$answer" == 4 ]; then
    sudo pacman -Sy tailscale
    sudo systemctl enable --now tailscaled.service
    sudo tailscale login
fi
if [ "$answer" == 5 ]; then
    read -p "Please write correct path to existing directory(or if you want to install not in the current directory please type ENTER):" path
    if [ -z "$path" ]; then
        git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git 
    else
        git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git && mv zapret-discord-youtube-linux "$path"
    fi
fi
if [ "$answer" == 6 ]; then
    sudo systemctl start wg-quick@wg0.service
fi
if [ "$answer" == 5 ]; then
    read -p "Please write correct path to existing directory(or if you want to install not in the current directory please type ENTER):" path
    if [ -z "$path" ]; then
        git clone https://aur.archlinux.org/curseforge.git
        cd curseforge
        sudo -u deck makepkg -sri
    else
        git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git && mv zapret-discord-youtube-linux && mv "$path"
    fi
fi
if [ "$answer" == 8 ]; then
    exit 1
fi
git clone https://aur.archlinux.org/curseforge.git
        cd curseforge
        sudo -u deck makepkg -sri
