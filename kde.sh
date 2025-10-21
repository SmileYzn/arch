#!/bin/bash

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

# Limpar Tela
clear

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Abrir pasta do usuário atual
cd /home/$USUARIO

# Atualizar sistema
sudo pacman -Syyu --needed --noconfirm

# Pacotes Base
sudo pacman -S --needed --noconfirm 7zip alsa-firmware base-devel bash-completion fastfetch ffmpegthumbnailer git man power-profiles-daemon powertop reflector system-config-printer unace unzip unrar xz zip

# XDG Desktop e User Dirs
sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-kde xdg-utils

# Bluetoth, CUPS e Touchegg (Pacotes)
sudo pacman -S --needed --noconfirm blueman bluez cups

# Bluetoth, CUPS e Touchegg (Serviços)
sudo systemctl enable bluetooth cups touchegg

# Xorg e Wayland
sudo pacman -S --needed --noconfirm xorg-apps xorg-xwayland numlockx wayland

# NTFS, CIFS, GVFS
sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd

# Fontes adicionais
sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-droid ttf-opensans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family

# Atualizar o chace de fontes
sudo fc-cache -f -v

# Kvantum
sudo pacman -S --needed --noconfirm kvantum kvantum-qt5

# Firefox
sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br

# Thunderbird
sudo pacman -S --needed --noconfirm thunderbird thunderbird-i18n-pt-br

# Libreoffice
sudo pacman -S --needed --noconfirm libreoffice-fresh libreoffice-fresh-pt-br

# Aplicativos do KDE
sudo pacman -S --needed --noconfirm dolphin-plugins filelight gwenview kcalc kcharselect kcolorchooser kfind kolourpaint kwalletmanager okular partitionmanager plasma-systemmonitor vlc

# Instalar YAY no modo binário via AUR
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --needed --noconfirm
cd ..
rm -rf yay-bin

# Limpar pacotes redundantes
sudo pacman -R htop vim vim-runtime

# Limpar Pacotes
sudo pacman -Rcs --noconfirm $(pacman -Qdtq)

# Adicionar grupo autologin
sudo groupadd -r autologin

# Adicionar o usuário ao grupo
sudo gpasswd autologin -a ${USUARIO}

# Abrir pasta do usuário
cd /home/$USUARIO

# Criar pastas padrão
xdg-user-dirs-update

# Criar pastas
mkdir Desktop Downloads Modelos Rede Documentos Músicas Imagens Vídeos

# Alterar pastas
xdg-user-dirs-update --force --set DESKTOP /home/$USUARIO/Desktop
xdg-user-dirs-update --force --set DOWNLOAD /home/$USUARIO/Downloads
xdg-user-dirs-update --force --set TEMPLATES /home/$USUARIO/Modelos
xdg-user-dirs-update --force --set PUBLICSHARE /home/$USUARIO/Rede
xdg-user-dirs-update --force --set DOCUMENTS /home/$USUARIO/Documentos
xdg-user-dirs-update --force --set MUSIC /home/$USUARIO/Músicas
xdg-user-dirs-update --force --set PICTURES /home/$USUARIO/Imagens
xdg-user-dirs-update --force --set VIDEOS /home/$USUARIO/Vídeos

# Atualizar pastas padrão
xdg-user-dirs-update

# Remover pastas antigas
rm -rf Documents Music Pictures Public Templates Videos

# Fim
exit
