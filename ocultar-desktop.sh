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

# Ocultar Atalhos (Arch System Apps)
OCULTAR=(
    "/usr/share/applications/bvnc.desktop" \
    "/usr/share/applications/qv4l2.desktop" \
    "/usr/share/applications/bssh.desktop" \
    "/usr/share/applications/avahi-discover.desktop" \
    "/usr/share/applications/qvidcap.desktop" \
    "/usr/share/applications/cups.desktop" \
    "/usr/share/applications/java-java-openjdk.desktop" \
    "/usr/share/applications/jconsole-java-openjdk.desktop" \
    "/usr/share/applications/jshell-java-openjdk.desktop")

# Loop
for CAMINHO in "${OCULTAR[@]}"; do
    if [ -f "$CAMINHO" ]; then
        echo "NoDisplay=true" | sudo tee -a "$CAMINHO"
    fi
done

# Fim
exit
