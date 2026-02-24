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

# Clonar Fluent GTK Theme && Fluent Icon Theme
git clone https://github.com/vinceliuice/Fluent-gtk-theme.git
git clone https://github.com/vinceliuice/Fluent-icon-theme.git

# Abrir
cd Fluent-gtk-theme

# Parse SASSC
sh parse-sass.sh

# Instalar e linkar com libadwaita
sudo sh install.sh --icon arch --size standard --tweaks solid
sh install.sh --icon arch --size standard --tweaks solid
sh install.sh --icon arch --size standard --tweaks solid -c dark -l

# Voltar e abrir Fluent Icon Theme
cd /home/$USUARIO
cd Fluent-icon-theme

# Instalar Icones
sudo sh install.sh

# Abrir Cursors
cd cursors

# Instalar Cursores
sudo sh install.sh

# Abrir pasta do usuário
cd /home/$USUARIO

# Remover pastas
rm -rf Fluent-gtk-theme
rm -rf Fluent-icon-theme

# Fim
exit
