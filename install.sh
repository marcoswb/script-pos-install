#!/usr/bin/env bash
RED='\033[05;31m' # RED COLOR
NC='\033[0m' # NO COLOR

install_aplications(){
    clear
    printf "${RED}INSTALLING SPOTIFY(1/9)${NC}"
    sudo dnf install -y flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    sudo flatpak install flathub com.spotify.Client -y

    clear
    printf "${RED}INSTALLING VIRTUALBOX(2/9)${NC}"
    sudo wget -v https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1-6.1.22_144080_fedora33-1.x86_64.rpm -O virtualbox.rpm
    sudo dnf install SDL -y
    sudo rpm -U virtualbox.rpm
    sudo dnf install kernel-devel -y
    sudo sudo dnf install dkms -y

    clear
    printf "${RED}INSTALLING VAGRANT(3/9)${NC}"
    sudo wget -v https://releases.hashicorp.com/vagrant/2.2.15/vagrant_2.2.15_x86_64.rpm -O vagrant.rpm
    sudo rpm -U vagrant.rpm

    clear
    printf "${RED}INSTALLING BITWARDEN(4/9)${NC}"
    sudo wget -v "https://vault.bitwarden.com/download/?app=desktop&platform=linux&variant=rpm" -O bitwarden.rpm
    sudo rpm -U bitwarden.rpm

    clear
    printf "${RED}INSTALLING ONLYOFFICE(5/9)${NC}"
    sudo wget -v https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm?_ga=2.56345773.764533964.1595236576-1157782750.1587541027 -O onlyoffice.rpm
    sudo dnf install liberation-narrow-fonts -y
    sudo rpm -U onlyoffice.rpm

    clear
    printf "${RED}INSTALLING GIMP(6/9)${NC}"
    sudo dnf install gimp -y

    clear
    printf "${RED}INSTALLING VIM(7/9)${NC}"
    sudo dnf install vim -y

    clear
    printf "${RED}INSTALLING VISUAL STUDIO CODE(8/9)${NC}"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf check-update
    sudo dnf install code -y

    clear
    printf "${RED}INSTALLING WEBAPP NOTION(9/9)${NC}"
    mkdir "$HOME/WebApps"
    cd "$HOME/WebAppps"
    sudo dnf install nodejs npm -y
    sudo npm install nativefier -g
    nativefier --name "Notion" https://www.notion.so/

}

configurations(){
    clear
    printf "${RED}INSTALLING ICONS AND THEME${NC}"
    sudo dnf install gnome-shell-theme-flat-remix -y
    gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Blue-Dark"
    gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue-Dark"

    clear
    printf "${RED}INSTALLING EXTENSIONS FOR VISUAL STUDIO CODE${NC}"
    list_extensions=("formulahendry.auto-rename-tag" "coenraads.bracket-pair-colorizer-2" "naumovs.color-highlight" "dracula-theme.theme-dracula" "abusaidm.html-snippets" "pkief.material-icon-theme" "yzhang.markdown-all-in-one" "ms-python.vscode-pylance")
    
    for ext in "${list_extensions[@]}"
    do
        code --install-extension $ext
    done

    clear
    printf "${RED}WHAT NAME DO YOU WANT TO USE IN GIT user.name?${NC}"
    read -r git_config_user_name
    git config --global user.name "$git_config_user_name"

    printf "${RED}WHAT EMAIL DO YOU WANT TO USE IN GIT user.email?${NC}"
    read -r git_config_user_email
    git config --global user.email "$git_config_user_email"

    clear
    printf "${RED}CLONE REPOSITORIES GITHUB${NC}"
    mkdir "$HOME/Projects"
    cd "$HOME/Projects"

    list_repositories=("https://github.com/marcoswb/youtube_downloader.git" "https://github.com/marcoswb/personal-site.git" "https://github.com/marcoswb/script-pos-install.git")
    for repo in "${list_repositories[@]}"
    do
        git clone $repo
    done

    clear
    printf "${RED}INSTALLING ZSH${NC}"
    sudo dnf install zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    sudo dnf install util-linux-user -y
    chsh -s $(which zsh)

    clear
    printf "${RED}INSTALLING TERMINAL THEME${NC}"
    git clone https://github.com/dracula/gnome-terminal
    cd gnome-terminal
    ./install.sh
}

install_aplications
configurations
