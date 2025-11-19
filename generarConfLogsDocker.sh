#!/bin/bash

# Contenido que deseas escribir en daemon.json
CONFIG='{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}'

echo "$CONFIG" | sudo tee /etc/docker/daemon.json >/dev/null
systemctl restart docker
echo "Configuracion de logs de docker, lista"
