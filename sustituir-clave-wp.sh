#!/usr/bin/bash

TAM=$(( RANDOM % 25+15 ))
CLAVE=$(openssl rand -base64 $TAM)
ORIG="WORDPRESS_DB_PASSWORD=wordpress"
REST="WORDPRESS_DB_PASSWORD=$CLAVE"
ORIG1="MYSQL_PASSWORD=wordpress"
REST1="MYSQL_PASSWORD=$CLAVE"

FILE=$(find . -print|grep env-Example)

sed -i "s|${ORIG}|${REST}|g" "$FILE"
sed -i "s|${ORIG1}|${REST1}|g" "$FILE"
