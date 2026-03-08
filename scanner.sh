#!/bin/bash
if [ -d "$1" ]; then
    echo -e "=== Rapport de scan pour le dossier : $1 ==="
    echo  -n " nombre de fichiers suspects : "
    grep -El "xor|locked|ransom" --exclude="scanner.sh" "$1"*.sh 2>/dev/null | wc -l 
    echo -n " nombre de fichiers cachés: "
    find "$1" -type f -name ".cs_count" -o -name ".cryptoshell_key" | wc -l 
    echo -n " nombre de fichiers locked: "
    find "$1" -type f -name "*.locked" | wc -l 
    echo -n " nombre de fichiers ransom_note.txt: "
    find "$1" -type f -name "ransom_note.txt" | wc -l 
    echo " === Fin du rapport ==="
else
    echo "mauvaise utilisation : bash $0 <dossier>"
    exit 1
fi
