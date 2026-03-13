#!/bin/bash

######################################################
# FAÇA A INSTALAÇÃO MÍNIMA DO XORG VIA ARCH INSTALLER
######################################################

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
sudo pacman -S --needed --noconfirm 7zip alsa-firmware base-devel bash-completion fastfetch ffmpeg ffmpegthumbnailer git man nano-syntax-highlighting power-profiles-daemon powertop reflector udisks2 unace unzip unrar xz zip

# Pacotes XDG Desktop e User Dirs
sudo pacman -S --needed --noconfirm xdg-user-dirs xdg-user-dirs-gtk xdg-desktop-portal xdg-desktop-portal-gtk xdg-utils

# Xorg e Wayland
sudo pacman -S --needed --noconfirm numlockx xiccd xorg-apps xorg-xinit

# Bluetoth, CUPS e Touchegg (Pacotes)
sudo pacman -S --needed --noconfirm blueman bluez cups

# Bluetoth, CUPS e Touchegg (Serviços)
sudo systemctl enable bluetooth cups

# NTFS, CIFS, GVFS
sudo pacman -S --needed --noconfirm cifs-utils ntfs-3g exfat-utils gvfs gvfs-afc gvfs-dnssd gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-onedrive gvfs-smb gvfs-wsdd

# Fontes adicionais
sudo pacman -S --needed --noconfirm adobe-source-code-pro-fonts adobe-source-sans-fonts adobe-source-serif-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra ttf-dejavu ttf-droid ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-opensans ttf-roboto ttf-roboto-mono ttf-ubuntu-font-family

# Atualizar o chace de fontes
sudo fc-cache -f -v

# LXDE + LXDM
sudo pacman -S --needed --noconfirm iso-codes libnotify lxde lxdm notification-daemon network-manager-applet pavucontrol picom simple-scan system-config-printer

# Ativar serviço LXDM
sudo systemctl enable lxdm

# Adwaita
sudo pacman -S --needed --noconfirm adwaita-cursors adwaita-fonts adwaita-icon-theme adwaita-icon-theme-legacy

# Firefox
sudo pacman -S --needed --noconfirm firefox firefox-i18n-pt-br

# Pacotes Extras
sudo pacman -S --needed --noconfirm dconf-editor galculator gcolor3 gigolo gnome-screenshot gparted l3afpad mugshot mpv seahorse xarchiver xpdf xscreensaver

# PKGFILE (Retorno de comando não encontrado)
sudo pacman -S --needed --noconfirm pkgfile
sudo pkgfile --update
echo "source /usr/share/doc/pkgfile/command-not-found.bash" >> ~/.bashrc

# Habilitar notification Daemon
sudo cp /usr/share/applications/notification-daemon.desktop /etc/xdg/autostart/

# YAY (Arch User Repository)
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si --needed --noconfirm
cd ..
rm -rf yay-bin

# Limpar pacotes
sudo pacman -Rnscu --noconfirm htop vim vim-runtime

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

# Nano syntax highlighting
echo 'include "/usr/share/nano/*.nanorc"' | sudo tee -a /etc/nanorc > /dev/null

# Configuração do LXDE Panel
LXPANEL="/Td6WFoAAATm1rRGBMD8BYgQIQEWAAAAAAAAAFlrPSfgCAcC9F0AEYgKCCHMlGgedS3yj4gZAZo+EbH9bnvQzmht+lr00B61+5a14Byz7h8C5yN/5v5WjM1dPql+4E8p2WQTIXQjzztYOVwKj5wlnJQK/Z+bF+zHX4WlEnpThXhODmwwf2j0OdiIVEDJgamlNZQS41KbWPVwIaRLCz6F+krYbTlKi4EwG9v9CGXoNtNlXY4JSL3K9mVVe8iCewTR2QwKcotDwSvX3QAlX9oL1TPfe81kuTpnkR7fgfWyb/sygOIy/92X3GrEXDPOls630ndpS/col/omVTENeTbt60MvuJcLrODxjHQ3gaOwkXsTm5n8RmtFncNrIc20xDLY9VRXUW4UoUVvt5QagbzAvY8dL1WuICGIFrY5gDAU+SRjf2d7MV8l4YxUkAp6bulR7+DGNhXeCl6+mYmtoVDolIigvSCiA8dlYLv+hhd31RWiQ/9XnA2UDW1RGunYnNP/VzR0xzZUgbYRL/M5VHQ+OQ0qm7rcLNZWAE3v7y+9oK0SblAfi1Hiu2ooEsK6vj96sxp82rPJqweUzWVhY6Mbh2ArW9Mee2le0uEULE/VfFPzUPAD0482a3qPhXcVfMIh4bpAEeZ1iXJGtUeu/McLHE+C7Y31DzOSDuUOCbVRupscY9jUG4che6Se5gxLC4UAWzj4m6VreOEBvJAWz9qMiOp2xxEmyGL6/A3s0iw4yAaj+s1aL0GirgiKRxtGw2OS8ub/YKdNiSWkOnCZ1J7FQ4JmYzi8A4LKw/owMwoQCC5b2n/0Rn/SD1fENxzaA5FIWKOUlfLfu3lOgKFLP2YcL+oiC7UZ+VQ00YDJiXVOjZa9b+U8BBs5iVdSnilT/UNj5smpHVxajXOZqVowskVBueeEKMJrciKINBKxN7KRNFYswLDmFwsBXfjps/mg/b89slXd4pn6J2Hz3NwFa4YwCF1m5/gq94hIXHTUbsmxSb7hrcwAqb/FUbvP57HadD5SbJE3ZYt2L/nylHC3UQaiZy89zv4i7BgWJQgAAGN8UMTUZwtjAAGYBogQAAD3iOuJscRn+wIAAAAABFla"
mkdir -p /home/$USUARIO/.config/lxpanel/LXDE/panels
echo "$LXPANEL" | base64 -d | unxz -c > /home/$USUARIO/.config/lxpanel/LXDE/panels/panel

