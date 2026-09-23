#!/bin/bash

# Limpar
clear

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo "Esse script NÃO deve ser executado como root"
    exit 1
fi

# Abrir pasta do usuário
cd "$HOME" || exit 1

# Atualizar sistema
sudo pacman -Syyu --needed --noconfirm

# Pacotes Base
sudo pacman -S --needed --noconfirm \
7zip \
alsa-firmware \
base-devel \
bash-completion \
blueman \
bluez \
fastfetch \
fwupd \
ffmpeg \
ffmpegthumbnailer \
git \
numlockx \
power-profiles-daemon \
powertop \
reflector \
udisks2 \
unace \
unzip \
unrar \
xiccd \
xz \
zip

# Pacotes XDG Desktop e User Dirs
sudo pacman -S --needed --noconfirm \
xdg-user-dirs \
xdg-user-dirs-gtk \
xdg-desktop-portal \
xdg-desktop-portal-gtk \
xdg-utils

# CIFS, EXFAT, GVFS, NTFS
sudo pacman -S --needed --noconfirm \
cifs-utils \
exfat-utils \
gvfs \
gvfs-dnssd \
gvfs-goa \
gvfs-mtp \
gvfs-nfs \
gvfs-smb \
gvfs-wsdd \
ntfs-3g

# Fontes adicionais
sudo pacman -S --needed --noconfirm \
adobe-source-code-pro-fonts \
adobe-source-sans-fonts \
adobe-source-serif-fonts \
noto-fonts \
noto-fonts-cjk \
noto-fonts-emoji \
noto-fonts-extra \
ttf-dejavu \
ttf-droid \
ttf-fira-code \
ttf-fira-mono \
ttf-fira-sans \
ttf-opensans \
ttf-roboto \
ttf-roboto-mono \
ttf-ubuntu-font-family

# XFCE4 Plugins
sudo pacman -S --needed --noconfirm \
xfce4-goodies \
xfce4-docklike-plugin \
xfce4-mixer \
xfce4-panel-profiles \
xfce4-volumed-pulse \
xfce4-windowck-plugin

# Thunar
sudo pacman -S --needed --noconfirm \
thunar-media-tags-plugin \
thunar-archive-plugin \
thunar-shares-plugin \
thunar-volman

# Firefox
sudo pacman -S --needed --noconfirm \
firefox  \
firefox-i18n-pt-br

# GStreamer
sudo pacman -S --needed --noconfirm  \
gstreamer  \
gst-libav  \
gst-plugins-base  \
gst-plugins-good  \
gst-plugins-bad  \
gst-plugins-ugly

# Pacotes Extras
sudo pacman -S --needed --noconfirm  \
catfish  \
galculator  \
gcolor3  \
gthumb  \
lightdm-gtk-greeter-settings  \
mugshot  \
orage  \
parole  \
seahorse

# Atualizar o chace de fontes
sudo fc-cache -f -v

# Serviços
sudo systemctl enable bluetooth

# YAY (Arch User Repository)
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --needed --noconfirm
cd ..
rm -rf yay-bin

# Limpar pacotes
sudo pacman -R --noconfirm htop vim vim-runtime

# Limpar dependências
sudo pacman -Rcs --noconfirm $(pacman -Qdtq)

# Adicionar grupo autologin
sudo groupadd -r autologin

# Adicionar o usuário ao grupo
sudo gpasswd autologin -a "$USER"

# Abrir pasta do usuário
cd "$HOME" || exit 1

# Criar pastas padrão
xdg-user-dirs-update

# Criar pastas
mkdir Desktop Documentos Downloads Imagens Modelos Músicas Projetos Rede Vídeos

# Alterar pastas
xdg-user-dirs-update --force --set DESKTOP "$HOME/Desktop"
xdg-user-dirs-update --force --set DOCUMENTS "$HOME/Documentos"
xdg-user-dirs-update --force --set DOWNLOAD "$HOME/Downloads"
xdg-user-dirs-update --force --set PICTURES "$HOME/Imagens"
xdg-user-dirs-update --force --set TEMPLATES "$HOME/Modelos"
xdg-user-dirs-update --force --set MUSIC "$HOME/Músicas"
xdg-user-dirs-update --force --set PROJECTS "$HOME/Projetos"
xdg-user-dirs-update --force --set PUBLICSHARE "$HOME/Rede"
xdg-user-dirs-update --force --set VIDEOS "$HOME/Vídeos"

# Atualizar pastas padrão
xdg-user-dirs-update

# Remover pastas antigas
rm -rf Documents Music Pictures Projects Public Templates Videos

# Limpar histórico
history -c && > ~/.bash_history

# Fim
exit 0
