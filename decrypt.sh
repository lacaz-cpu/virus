#!/bin/bash

source xor_helper.sh
decrypt_file() {
    if [ -f .cryptoshell_key ]; then
        key=$(<.cryptoshell_key)
        xor_file "$1" "${1%.locked}" "$key"
        rm -f "$1"
    else
        echo "Aucun fichier .cryptoshell_key trouvé. Impossible de décrypter $1."
    fi
}

#key=$(<.cryptoshell_key)
#xor_file "$1" "${1%.locked}" "$key"
#rm -f "$1"