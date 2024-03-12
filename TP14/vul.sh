#!/bin/bash

# Chemin vers le fichier de sortie
OUTPUT_FILE="/home/user/SAE61/TP14/debsecan_vul.txt"

# Seuil de vulnérabilités
SEUIL=10

# Adresse e-mail de destination
EMAIL_DESTINATION="ibrahimalkaisi.iut@gmail.com"

# Serveur SMTP
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USERNAME="ibrahimalkaisi.iut@gmail.com"
SMTP_PASSWORD="J'ai essayé mais cela ne fonctionne pas, il prend bcp de temps mais pas de résultats, par contre il génére le fichier de scan"

# Chemin complet vers ssmtp
SSMTP_PATH="/usr/sbin/ssmtp"

# Exécuter debsecan et enregistrer la sortie dans le fichier
debsecan --suite=bookworm --format detail >> "$OUTPUT_FILE"

# Nombre de vulnérabilités trouvées
NUM_VUL=$(grep -c 'vulnerability' "$OUTPUT_FILE")

# Envoyer un e-mail d'alerte si le nombre de vulnérabilités dépasse le seuil
if [ "$NUM_VUL" -gt "$SEUIL" ]; then
    SUBJECT="Alerte de sécurité - Nombre de vulnérabilités dépasse le seuil"
    BODY="Le nombre de vulnérabilités trouvées ($NUM_VUL) dépasse le seuil autorisé ($SEUIL). Veuillez vérifier le fichier $OUTPUT_FILE pour plus de détails."

    # Envoyer l'e-mail en utilisant ssmtp avec le chemin complet
    echo -e "Subject:$SUBJECT\n$BODY" | "$SSMTP_PATH" -v -au"$SMTP_USERNAME" -ap"$SMTP_PASSWORD" "$EMAIL_DESTINATION"
fi

# Historiser les résultats dans un fichier log
LOG_FILE="/home/user/SAE61/TP14/debsecan_log.txt"
echo "$(date): Nombre de vulnérabilités trouvées - $NUM_VUL" >> "$LOG_FILE"

