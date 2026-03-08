#!bin/bash

source decrypt.sh

if [ -d "$1" ]; then
    if [ $(find "$1" -type f -name ".cryptoshell_key" | wc -l) -gt 0 ]; then
        find "$1" -type f -name "*.locked" | while read -r file; do
            decrypt_file "$file"
            
        done
        rm -f "$1/.cryptoshell_key"
        find "$1" -type f -name "ransom_note.txt" -delete
        exit 1
    else
        echo "Aucun fichier .cryptoshell_key trouvé dans le dossier spécifié."
        exit 1
    fi
else
    echo "mauvaise utilisation : bash $0 <dossier>"
    exit 1
fi
