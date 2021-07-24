#!/usr/bin/env bash

install_aplications(){
    echo 'INSTALLING SPOTIFY(1/8)'
    sudo dnf install -y flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install flathub com.spotify.Client -y

    echo 'INSTALLING VIRTUALBOX(2/8)'
    sudo wget -v https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1-6.1.22_144080_fedora33-1.x86_64.rpm -O virtualbox.rpm
    sudo dnf install SDL -y
    sudo rpm -U virtualbox.rpm
    sudo dnf install kernel-devel -y
    sudo sudo dnf install dkms -y

    echo 'INSTALLING VAGRANT(3/8)'
    sudo wget -v https://releases.hashicorp.com/vagrant/2.2.15/vagrant_2.2.15_x86_64.rpm -O vagrant.rpm
    sudo rpm -U vagrant.rpm

    echo 'INSTALLING SIMPLENOTE(4/8)'
    sudo wget -v https://github.com/Automattic/simplenote-electron/releases/download/v2.12.0/Simplenote-linux-2.12.0-x86_64.rpm -O simplenote.rpm
    sudo rpm -U simplenote.rpm

    echo 'INSTALLING ONLYOFFICE(5/8)'
    sudo wget -v https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm?_ga=2.56345773.764533964.1595236576-1157782750.1587541027 -O onlyoffice.rpm
    sudo dnf install liberation-narrow-fonts -y
    sudo rpm -U onlyoffice.rpm

    echo 'INSTALLING GIMP(6/8)'
    sudo dnf install gimp -y

    echo 'INSTALLING GIT(7/8)'
    sudo dnf install git -y

    echo 'INSTALLING VISUAL STUDIO CODE(8/8)'
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install code -y
}

configurations(){
    echo 'INSTALLING ICONS AND THEME'
    wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    sudo dnf install gnome-shell-theme-flat-remix -y
    gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"

    echo 'EXTENSIONS FOR VISUAL STUDIO CODE'
    list_extensions=("formulahendry.auto-rename-tag" "coenraads.bracket-pair-colorizer-2" "naumovs.color-highlight" "dracula-theme.theme-dracula" "abusaidm.html-snippets" "pkief.material-icon-theme" "yzhang.markdown-all-in-one" "ms-python.vscode-pylance")
    
    for ext in "${list_extensions[@]}"
    do
        code --install-extension $ext
    done

    echo "WHAT NAME DO YOU WANT TO USE IN GIT user.name?"
    read -r git_config_user_name
    git config --global user.name "$git_config_user_name"

    echo "WHAT EMAIL DO YOU WANT TO USE IN GIT user.email?"
    read -r git_config_user_email
    git config --global user.email "$git_config_user_email"

    echo 'CLONE REPOSITORIES GITHUB'
    mkdir "$HOME/Projects"
    cd "$HOME/Projects"

    list_repositories=("https://github.com/marcoswb/script-pos-install.git" "https://github.com/marcoswb/youtube_downloader.git" "https://github.com/marcoswb/personal-site.git")
    for repo in "${list_repositories[@]}"
    do
        git clone $repo
    done

    echo "THEME TERMINAL"
    git clone https://github.com/dracula/gnome-terminal
    cd gnome-terminal
    ./install.sh
}

finish(){
    echo 'RESTART SYSTEM'
    reboot
}

install_aplications
configurations
finish
