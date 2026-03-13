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

# Clonar Qogir GTK
git clone https://github.com/vinceliuice/Qogir-theme.git

# Clonar Qogir Icon
git clone https://github.com/vinceliuice/Qogir-icon-theme.git

# Clonar Qogir Openbox
git clone https://github.com/tr1nh/qogir-theme-openbox.git


# Abrir Qogir Theme
cd /home/$USUARIO
cd Qogir-theme

# Instalar e linkar com libadwaita
sh install.sh -i arch
sudo sh install.sh -i arch
sudo sh install.sh -i arch -c dark -l

# Abrir Qogir Icon
cd /home/$USUARIO
cd Qogir-icon-theme

# Instalar Icones
sudo sh install.sh -t default

# Abrir Qogir Openbox
cd /home/$USUARIO
cd qogir-theme-openbox

# Instlar
sudo cp -r Qogir-Dark /usr/share/themes
sudo cp -r Qogir-Light /usr/share/themes

# Remover pastas
sudo rm -rf /home/$USUARIO/Qogir-theme
sudo rm -rf /home/$USUARIO/Qogir-icon-theme
sudo rm -rf /home/$USUARIO/qogir-theme-openbox

# Fim
exit
