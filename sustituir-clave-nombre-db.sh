#!/usr/bin/bash

DIRECTORY=$(find . -type d)

for dir in $DIRECTORY; do DBNAME=$(basename "$dir"); done

ORIG="MYSQL_DATABASE=wordpress"
REST="MYSQL_DATABASE=$DBNAME"
ORIG1="WORDPRESS_DB_NAME=wordpress"
REST1="WORDPRESS_DB_NAME=$DBNAME"

FILE=$(find . -print|grep env-Example)

sed -i "s|${ORIG}|${REST}|g" "$FILE"
sed -i "s|${ORIG1}|${REST1}|g" "$FILE"
