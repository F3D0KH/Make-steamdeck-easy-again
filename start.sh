#!/bin/bash
echo >> "############################################"
echo >> "#                                          #"
echo >> "# Tool to make your work on steamdeck easier!"
echo >> "#             by F3D0KH                    #"
echo >> "############################################"

echo >> "Choose your option:"
echo >> "1) Readonly disable"
echo >> "2) Fuck you pacman!(Switch SigLevel)"
read answer
if ($answer == 1) {
  sudo steamos-readonly disable
}
if ($answer == 2) {
  sudo sed -i '42s/SigLevel = "Required DatabaseOptional"/SigLevel = Never'
}
