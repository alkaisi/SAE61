#!/bin/bash

# Chemin vers les répertoires des Vagrantfiles
server_dir="/home/user/SAE61/sae_Firewall/server"
client_dir="/home/user/SAE61/sae_Firewall/client"

# Fonction pour ouvrir un terminal et lancer Vagrant
launch_vagrant() {
    cd "$1"
    gnome-terminal -- bash -c "vagrant up; exec bash"
}

# Ouvrir un terminal pour le serveur
launch_vagrant "$server_dir" &

# Attendre un peu pour éviter les problèmes de synchronisation
sleep 10

# Ouvrir un terminal pour le client
launch_vagrant "$client_dir" &

