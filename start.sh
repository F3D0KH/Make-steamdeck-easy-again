#!/bin/bash
echo >> "##########################################№##"
echo >> "#                                           #"
echo >> "# Tool to make your work on steamdeck easier!"
echo >> "#             by F3D0KH                     #"
echo >> "##########################################№##"

echo >> "Choose your option:"
echo >> "1) Readonly disable"
echo >> "2) Update all pkg"
echo >> "3) Fuck you pacman!(Switch SigLevel)"
echo >> "4) Install tailscale"
echo >> "5) Download latest version zapret(linux)"
read answer
if ($answer == 1) {
  sudo steamos-readonly disable
}
if ($answer == 2) {
  sudo pacman -Suy
}
if ($answer == 3) {
  sudo sed -i '42s/.*/SigLevel = Never/' /etc/pacman.conf
}
if ($answer == 4) {
  sudo pacman -Sy tailscale
}
if ($answer == 5) {
  read -p "Please write correct path to existing directory(or if you want to install not in the current directory please type " "):" path
  if ($path == " ") {
    git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git 
  } else {
    git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git $path
  }
}
