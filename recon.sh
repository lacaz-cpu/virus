#!/bin/bash
recon(){
    if [ -e "$1" ]; then
        echo "Analyse de $1 : "  
    count=0
    taille=0
    while read -r file; do
        count=$((count + 1))
        taille=$((taille + $(du -b "$file" | cut -f1)))
        echo "Chemin $file"
        echo "taille $(du -b "$file" | cut -f1) octets"
        echo "date de modification $(stat -c %y "$file") "
        echo $file >> target.list
    done < <(find "$1" -type f \( -name '*.dat' -o -name '*.txt' \))

    echo "Total de fichiers trouvés : $count"
    echo "Taille totale : $taille octets"
    else
        echo "Chemin '$1' inexistant" 
        exit 1
    fi 
}