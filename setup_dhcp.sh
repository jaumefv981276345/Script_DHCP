#!/bin/bash

# Objetivo: Script de Ubuntu KEA (DHCP)
# Author: Jaume Fuster Valls
# ------------------------------------------

# Declare STRING variable
STRING="Script per instalar i configurar KEA"
# Print variable on screen
echo $STRING

# Declare variables to download files from GitHub
#TOKEN=""
#headerToken="--header Authorization: token $TOKEN"
headerToken=""
OWNER="jaumefv981276345"
REPO="Script_DHCP"
PATHFILE="main/kea-dhcp4.conf"
CONFIG_URL="https://raw.githubusercontent.com/$OWNER/$REPO/$PATHFILE"

# Print CONFIG_URL on screen
echo "URL configuración: $CONFIG_URL"

# Install KEA DHCP
echo "Instalando KEA DHCP..."
sudo apt install kea -y

# Backup del archivo de configuración original
 sudo mv /etc/kea/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf.original
 echo "Archivo original respaldado como kea-dhcp4.conf.original"

# Download GitHub configuration file
echo "Descargando archivo de configuración..."
curl "$CONFIG_URL"

# Convertir a formato Unix por si viene de Windows
dos2unix kea-dhcp4.conf

# Copy configuration file to etc directory
sudo cp kea-dhcp4.conf /etc/kea/kea-dhcp4.conf

# Restart KEA DHCP service
echo "Reiniciando KEA DHCP..."
sudo systemctl restart kea-dhcp4-server
sudo systemctl enable kea-dhcp4-server

echo "¡Configuración de KEA DHCP completada!"