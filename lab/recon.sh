#!/bin/bash
if [ -e "$1" ]; then
    echo "Analyse de $1 : "  
find "$1" -type f \( -name '*.dat' -o -name '*.txt' \) | while read -r file; do
    echo "Chemin $file"
    echo "taille $(du -b "$file" | cut -f1) octets"
    echo "date de modification $(stat -c %y "$file") "
done

else
    echo "Chemin '$1' inexistant"
    exit 1
fi 