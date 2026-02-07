#!/bin/bash
if [ "$(whoami)" != 'root' ]; then
    echo "Sorry, this script requires root. Please relaunch like that -> sudo ./start.sh"
    exit 1
fi

# Исправленная функция спиннера
show_spinner() {
    local pid=$1
    local message="$2"
    local delay=0.1
    local spinstr='|/-\'
    tput sc
    
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "\r%s [%c]" "$message" "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b"
    done
    tput rc
    tput ed
}

# backup (why?)
#show_spinner_simple() {
#    local pid=$1
#    local message="$2"
#    local spin='|/-\'
    
    echo -n "$message "
    
    while kill -0 $pid 2>/dev/null; do
        for i in $(seq 0 3); do
            echo -ne "\r$message [${spin:$i:1}]"
            sleep 0.1
        done
    done
    
    echo -ne "\r$message [✓]"
    echo
}

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
    sudo steamos-readonly disable &
    show_spinner_simple $! "Disabling readonly..."
fi

if [ "$answer" == 2 ]; then
    sudo pacman -Suy &
    show_spinner_simple $! "Updating packages..."
fi

if [ "$answer" == 3 ]; then
    sudo sed -i '42s/.*/SigLevel = Never/' /etc/pacman.conf &
    show_spinner_simple $! "Changing SigLevel..."
fi

if [ "$answer" == 4 ]; then
    echo "Installing tailscale..."
    sudo pacman -Sy tailscale &
    show_spinner_simple $! "Installing tailscale..."
    wait
    
    sudo systemctl enable --now tailscaled.service &
    show_spinner_simple $! "Starting tailscale service..."
    wait
    
    sudo tailscale login
fi

if [ "$answer" == 5 ]; then
    read -p "Please write correct path to existing directory(or if you want to install in the current directory please type ENTER):" path
    
    if [ -z "$path" ]; then
        echo "Downloading zapret..."
        git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git &
        show_spinner_simple $! "Downloading repo"
        wait
        
        current_dir=$(pwd)
        mv zapret-discord-youtube-linux/ "$current_dir/zapret" &
        show_spinner_simple $! "Moving files"
        wait
        
        echo "Work complete!"
    else
        echo "Downloading zapret..."
        git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux.git &
        show_spinner_simple $! "Downloading repo"
        wait
        
        HDZ="$path/zapret"
        mv zapret-discord-youtube-linux "$HDZ" &
        show_spinner_simple $! "Moving to $path"
        wait
        
        echo "Work complete!"
    fi
fi

if [ "$answer" == 6 ]; then
    sudo systemctl start wg-quick@wg0.service &
    show_spinner_simple $! "Starting WireGuard..."
fi

if [ "$answer" == 7 ]; then
    read -p "Please write correct path to existing directory(or if you want to install in the current directory please type ENTER):" path
    
    if [ -z "$path" ]; then
        echo "Downloading curseforge..."
        git clone https://aur.archlinux.org/curseforge.git &
        show_spinner_simple $! "Downloading curseforge"
        wait
        
        cd curseforge
        echo "Building package..."
        sudo -u deck makepkg -sri &
        # Для makepkg нужен отдельный обработчик, так как это долгая операция
        echo "Building package (this may take a while)..."
        wait
    else
        echo "Downloading curseforge..."
        git clone https://aur.archlinux.org/curseforge.git &
        show_spinner_simple $! "Downloading repo"
        wait
        
        mv curseforge "$path" &
        show_spinner_simple $! "Moving repo to $path"
        wait
        
        echo "Building package (this may take a while)..."
        cd "$path/curseforge"
        sudo -u deck makepkg -sri -C &
        # Просто показываем процесс, так как makepkg сам показывает прогресс
        wait
    fi
fi

if [ "$answer" == 8 ]; then
    exit 1
fi
