#!/bin/bash

# Chemin vers le fichier de sortie
OUTPUT_FILE="/home/user/SAE61/TP14/debsecan_vul.txt"

# Exécuter debsecan et enregistrer la sortie dans le fichier
/usr/sbin/debsecan --suite=bookworm --format detail > "$OUTPUT_FILE"
