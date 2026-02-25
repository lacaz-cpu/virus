#!/bin/bash

source xor_helper.sh

key=$(generate_key 8)
xor_file "$1" "$1.locked" "$key"
rm -f "$1"
echo "$key" > .cryptoshell_key