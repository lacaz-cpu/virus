#!/bin/bash

source xor_helper.sh

key=$(<.cryptoshell_key)
xor_file "$1" "${1%.locked}" "$key"
rm -f "$1"