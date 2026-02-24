#!/bin/bash

find "$1" -type f | while read -r file; do
    echo "Chemin $file"
    echo "taille $(du -h "$file" | cut -f1)"
    echo "date de modification $(stat -c %y "$file") \n"
done