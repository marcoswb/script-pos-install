#!/bin/bash

echo 'INSTALLING VISUAL STUDIO CODE(1/14)'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code

echo 'INSTALLING VAGRANT(2/14)'
wget -v https://releases.hashicorp.com/vagrant/2.2.15/vagrant_2.2.15_x86_64.rpm -O vagrant.rpm
sudo rpm -U vagrant.rpm

echo 'INSTALLING VIRTUALBOX(3/14)'
wget -v https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1-6.1.22_144080_fedora33-1.x86_64.rpm -o virtualbox.rpm
sudo rpm -U virtualbox.rpm
sudo dnf -y install kernel-devel kernel-headers

echo 'INSTALLING DISCORD(4/14)' 
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install discord -y

echo 'INSTALLING SIMPLENOTE(5/14)'
sudo wget -v https://github.com/Automattic/simplenote-electron/releases/download/v2.12.0/Simplenote-linux-2.12.0-x86_64.rpm -O simplenote.rpm
sudo rpm -U simplenote.rpm

echo 'INSTALLING ONLYOFFICE(6/14)'
wget -v https://download.onlyoffice.com/install/desktop/editors/linux/onlyoffice-desktopeditors.x86_64.rpm?_ga=2.56345773.764533964.1595236576-1157782750.1587541027 -O onlyoffice.rpm
sudo dnf install liberation-narrow-fonts
sudo rpm -U onlyoffice.rpm

echo 'INSTALLING GIMP(7/14)'
sudo dnf install gimp -y

echo 'INSTALLING GNOME-TWEAKS(8/14)'
sudo dnf install gnome-tweaks -y

echo 'INSTALLING GRUB-CUSTOMIZER(9/14)'
sudo dnf install grub-customizer -y

echo 'INSTALLING SPOTIFY(10/14)' 
sudo snap install spotify -y

echo 'INSTALLING GIT(11/14)' 
sudo dnf install git -y

echo "WHAT NAME DO YOU WANT TO USE IN GIT user.name?(12/14)"
read -r git_config_user_name
git config --global user.name "$git_config_user_name"

echo "WHAT EMAIL DO YOU WANT TO USE IN GIT user.email?(13/14)"
read -r git_config_user_email
git config --global user.email "$git_config_user_email"

echo 'INSTALLING ICONS AND THEME(14/14)'
sudo wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
sudo dnf install gnome-shell-theme-flat-remix -y

echo 'UPDATING AND RESTART SYSTEM'
clear
sudo dnf update -y
sudo reboot
