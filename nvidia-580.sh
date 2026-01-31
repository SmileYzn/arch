#!/bin/bash

# Usuário padrão (UID 1000)
USUARIO=$(id -nu 1000)

# Verificar acesso root
if [[ $EUID -eq 0 ]]; then
    echo -e "Esse script NÃO deve ser executado como ${USER}"
    exit
fi

# Verificar se o YAY está instalado
if ! yay --version &> /dev/null; then
    echo -e "Yet another yogurt (YAY) não está instaldo."
    exit
fi

# Abrir pasta do usuário atual
cd /home/$USUARIO

# Habilitar Color
sudo sed -i '/^#Color/s/^#//' /etc/pacman.conf

# Habilitar multilib
sudo sed -i '/^#\[multilib\]$/,/^#Include =/s/^#//' /etc/pacman.conf

# Atualizar
sudo pacman -Syyu --needed --noconfirm

# DKMS, GIT, Linux Headers
sudo pacman -S --needed --noconfirm base-devel dkms git linux-headers

# NVIDIA 580 (DKMS) Legacy
yay -S --noconfirm --needed nvidia-580xx-dkms nvidia-580xx-settings nvidia-580xx-utils opencl-nvidia-580xx

# NVIDIA 580 (Library Utils) Legacy
yay -S --noconfirm --needed lib32-nvidia-580xx-utils

# Limpeza
sudo pacman -Rcs $(pacman -Qdtq)

# Sair
exit

