#!/bin/bash

DIR="$PWD"
BA=$(which bash)


echo "Se requiere contraseña sudo para continuar…"
sudo -v || { echo "Error: autenticación fallida"; exit 1; }

# Ejecutar otro script con sudo
sudo "$BA" "$DIR"/generarConfLogsDocker.sh

