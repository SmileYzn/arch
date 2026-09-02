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

# Desativar compositor XFCE
xfconf-query -c xfwm4 -p /general/use_compositing -s false

# Instalar Picom via pacman
sudo pacman -S --needed --noconfirm picom

# Criar pasta de configuração picom
mkdir -p /home/$USUARIO/.config/picom/

# Copiar arquivo padrão do picom
cp /etc/xdg/picom.conf /home/$USUARIO/.config/picom/picom.conf

# Desativar sombras
sed -i 's/shadow = true;/shadow = false;/g' /home/$USUARIO/.config/picom/picom.conf

# Desativar fading
sed -i 's/fading = true;/fading = false;/g' /home/$USUARIO/.config/picom/picom.conf

# Desativar transparência
sed -i 's/frame-opacity = 0.9;/frame-opacity = 1.0;/g' /home/$USUARIO/.config/picom/picom.conf

# Trocar XRender por GLX no backend
sed -i 's/backend = "xrender"/backend = "glx"/g' /home/$USUARIO/.config/picom/picom.conf

# Iniciar o compositor
picom --daemon
