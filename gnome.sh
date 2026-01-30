#!/bin/bash

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Abrir pasta do usuário atual
cd /home/$USUARIO

# Atualizar
sudo pacman -Syyu --needed --noconfirm

# Pacotes Base
sudo pacman -S --needed --noconfirm 7zip alsa-firmware base-devel bash-completion fastfetch fwupd ffmpegthumbnailer git man power-profiles-daemon powertop reflector unace unzip unrar xz zip

# Pacotes XDG Desktop e User Dirs
sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gnome xdg-utils

# Bluetoth, CUPS e Touchegg (Pacotes)
sudo pacman -S --needed --noconfirm bluez cups touchegg

# Bluetoth, CUPS e Touchegg (Serviços)
sudo systemctl enable bluetooth cups touchegg

# NTFS, CIFS, GVFS, EXFAT
sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd

# Fontes adicionais
sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-droid ttf-opensans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family

# Atualizar cache
sudo fc-cache -f -v

# Adwaita
sudo pacman -S --needed --noconfirm adwaita-cursors adwaita-fonts adwaita-icon-theme adwaita-icon-theme-legacy

# GNOME Shell
sudo pacman -S --needed --noconfirm gnome-shell-extensions gnome-tweaks

# NAUTILUS
sudo pacman -S --needed --noconfirm nautilus-image-converter nautilus-share seahorse-nautilus sushi

# Firefox
sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br

# Thunderbird
sudo pacman -S --needed --noconfirm thunderbird thunderbird-i18n-pt-br

# Libreoffice
sudo pacman -S --needed --noconfirm libreoffice-fresh libreoffice-fresh-pt-br

# GNOME Core Apps
sudo pacman -S --needed --noconfirm baobab dconf-editor decibels file-roller gnome-backgrounds gnome-calculator gnome-calendar gnome-characters gnome-disk-utility gnome-font-viewer gnome-online-accounts gnome-system-monitor loupe papers seahorse showtime simple-scan

# Instalar o pacote YAY no modo binário
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --needed --noconfirm
cd ..
rm -rf yay-bin

# Remover Pacotes duplicados
sudo pacman -R htop vim vim-runtime

# Limpar dependências
sudo pacman -Rcs $(pacman -Qdtq)

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

# Ocultar Atalhos
#/usr/share/applications/bvnc.desktop
#/usr/share/applications/qv4l2.desktop
#/usr/share/applications/bssh.desktop
#/usr/share/applications/avahi-discover.desktop
#/usr/share/applications/java-java-openjdk.desktop
#/usr/share/applications/qvidcap.desktop
#/usr/share/applications/cups.desktop
#/usr/share/applications/system-config-printer.desktop


# Fim
exit
