#!/bin/bash
# CryptoShell XOR Helper — Fourni pour le TP
# Usage: source xor_helper.sh

# Génère une clé aléatoire de N octets (en hex)
generate_key() {
    local length=${1:-8}
    head -c "$length" /dev/urandom | xxd -p
}

# Chiffre/déchiffre un fichier avec une clé XOR (en hex)
# Usage: xor_file <input_file> <output_file> <hex_key>
xor_file() {
    local input="$1" output="$2" key="$3"
    local key_len=${#key}
    local i=0
    #echo "\n" >> "$input" 2>/dev/null mauvaise facon de corriger l'erreur de supression du dernier octet
    xxd -p "$input" | tr -d '\n' | fold -w2 | while read byte || [ -n "$byte" ]; do # permet de vérifier la dernière
    # qui lorsque executer avec un simple read ne rentre pas dans la boucle car read retourne une erreur -n $byte permet donc de corriger cela
        local ki=$(( i % (key_len / 2) ))
        local key_byte="${key:$((ki*2)):2}"
        printf "%02x" $(( 16#$byte ^ 16#$key_byte ))
        i=$((i + 1))
    done | xxd -r -p > "$output"
}
