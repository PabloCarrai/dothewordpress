#!/usr/bin/bash

OK="
⠀⠀⠀⠀⣠⣶⡾⠏⠉⠙⠳⢦⡀⠀⠀⠀⢠⠞⠉⠙⠲⡀⠀
⠀⠀⠀⣴⠿⠏⠀⠀⠀⠀⠀⠀⢳⡀⠀⡏⠀⠀⠀⠀⠀⢷
⠀⠀⢠⣟⣋⡀⢀⣀⣀⡀⠀⣀⡀⣧⠀⢸⠀⠀⠀⠀⠀ ⡇
⠀⠀⢸⣯⡭⠁⠸⣛⣟⠆⡴⣻⡲⣿⠀⣸⠀⠀OK⠀ ⡇
⠀⠀⣟⣿⡭⠀⠀⠀⠀⠀⢱⠀⠀⣿⠀⢹⠀⠀⠀⠀⠀ ⡇
⠀⠀⠙⢿⣯⠄⠀⠀⠀⢀⡀⠀⠀⡿⠀⠀⡇⠀⠀⠀⠀⡼
⠀⠀⠀⠀⠹⣶⠆⠀⠀⠀⠀⠀⡴⠃⠀⠀⠘⠤⣄⣠⠞⠀
⠀⠀⠀⠀⠀⢸⣷⡦⢤⡤⢤⣞⣁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⢀⣤⣴⣿⣏⠁⠀⠀⠸⣏⢯⣷⣖⣦⡀⠀⠀⠀⠀⠀⠀
⢀⣾⣽⣿⣿⣿⣿⠛⢲⣶⣾⢉⡷⣿⣿⠵⣿⠀⠀⠀⠀⠀⠀
⣼⣿⠍⠉⣿⡭⠉⠙⢺⣇⣼⡏⠀⠀⠀⣄⢸⠀⠀⠀⠀⠀⠀
⣿⣿⣧⣀⣿………⣀⣰⣏⣘⣆⣀⠀⠀
"

DIR="$PWD"
BA=$(which bash)
FI=$(which find)
ARCHIVO=$($FI "$DIR" -type f -name info)
PLUG="$DIR"/"$1"

help()
{
   echo "Script de creacion de sitio en docker-compose"
   echo
   echo "Uso: ./script url"
   echo "Es decir seria mas o menos asi"
   echo "     ./dothewordpressturururu.sh sitio.org"

}

while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
      *) # incorrect option
         echo "Error: Opcion invalida"
	 help
         exit;;
   esac
done

git clone https://github.com/PabloCarrai/wp-dockerizado.git &> /dev/null
mv "$DIR"/wp-dockerizado "$DIR"/"$1"

while IFS= read -r DOW 
do
  wget -P "$DIR"/"$1"/plugins/ "$DOW" &> /dev/null
done < "$ARCHIVO"

"$FI" "$PLUG" -type f -name "*.zip" -execdir unzip -qq '{}' ';' 
"$FI" "$PLUG" -type f -name "*.zip" -execdir rm -rf '{}' ';'

"$BA" "$DIR"/sustituir-clave-root-db.sh
"$BA" "$DIR"/sustituir-clave-wp.sh
"$BA" "$DIR"/sustituir-clave-nombre-db.sh

mv "$DIR"/"$1"/.env-Example "$DIR"/"$1"/.env
echo "$OK"
