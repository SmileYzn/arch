#!/bin/bash

# Limpar
clear

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Abrir pasta do usuário
cd /home/$USUARIO

# Atualizar sistema
sudo pacman -Syyu --needed --noconfirm

# Pacotes Base
sudo pacman -S --needed --noconfirm 7zip alsa-firmware base-devel bash-completion fastfetch ffmpegthumbnailer git man power-profiles-daemon powertop reflector system-config-printer unace unzip unrar xz zip

# Pacotes XDG Desktop e User Dirs
sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils

# Bluetoth, CUPS e Touchegg (Pacotes)
sudo pacman -S --needed --noconfirm blueman bluez cups

# Bluetoth, CUPS e Touchegg (Serviços)
sudo systemctl enable bluetooth cups

# Xorg e Wayland
sudo pacman -S --needed --noconfirm numlockx xorg-apps

# NTFS, CIFS, GVFS
sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd

# Fontes adicionais
sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-droid ttf-opensans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family

# Atualizar o chace de fontes
sudo fc-cache -f -v

# Adwaita
sudo pacman -S --needed --noconfirm adwaita-cursors adwaita-fonts adwaita-icon-theme adwaita-icon-theme-legacy

# XFCE4 Plugins
sudo pacman -S --needed --noconfirm xfce4-goodies xfce4-calculator-plugin xfce4-datetime-plugin xfce4-docklike-plugin xfce4-generic-slider xfce4-mixer xfce4-panel-profiles xfce4-stopwatch-plugin xfce4-volumed-pulse xfce4-windowck-plugin

# Thunar
sudo pacman -S --needed --noconfirm thunar-media-tags-plugin thunar-archive-plugin thunar-shares-plugin thunar-volman

# Firefox
sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br

# Pacotes Extras
sudo pacman -S --needed --noconfirm catfish dconf-editor drawing gcolor3 gigolo gparted gthumb lightdm-gtk-greeter-settings mate-calc mugshot orage parole peek seahorse simple-scan zeitgeist

# GStreamer
sudo pacman -S --needed --noconfirm gstreamer gst-libav gst-plugins-base gst-plugins-good gst-plugins-bad

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

# Ocultar Atalhos (Arch System Apps)
OCULTAR=(
    "/usr/share/applications/bvnc.desktop" \
    "/usr/share/applications/qv4l2.desktop" \
    "/usr/share/applications/bssh.desktop" \
    "/usr/share/applications/avahi-discover.desktop" \
    "/usr/share/applications/qvidcap.desktop" \
    "/usr/share/applications/cups.desktop")

# Loop through each element
for CAMINHO in "${OCULTAR[@]}"; do
    if [ -f "$FILE" ]; then
        echo "NoDisplay=true" | sudo tee -a "$CAMINHO"
    fi
done

# Fim
exit
