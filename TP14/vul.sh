#!/bin/bash

# Chemin vers le fichier de sortie
OUTPUT_FILE="/home/user/SAE61/TP14/debsecan_vul.txt"

# Suite Debian à analyser
DEBIAN_SUITE="bookworm"

# Seuil d'alerte pour le nombre de CVE
THRESHOLD=10

# Fonction pour envoyer une alerte par e-mail
send_email_alert() {
    local subject="Alerte : Dépassement du seuil de CVE"
    local body="Le nombre de CVE a dépassé le seuil autorisé. Veuillez vérifier le fichier $OUTPUT_FILE pour plus de détails."
    echo "$body" | mail -s "$subject" ibrahimalkaisi.iut@gmail.com
}

# Exécuter debsecan et enregistrer la sortie dans le fichier
/usr/sbin/debsecan --suite="$DEBIAN_SUITE" --format detail > "$OUTPUT_FILE"

# Vérifier si le nombre de CVE dépasse le seuil
num_cve=$(grep -c "CVE-" "$OUTPUT_FILE")
if [ "$num_cve" -gt "$THRESHOLD" ]; then
    send_email_alert
fi

# Ajouter des entrées dans le journal avec un horodatage
echo "$(date '+%Y-%m-%d %H:%M:%S') : Analyse de sécurité debsecan exécutée" >> /var/log/debsecan.log

