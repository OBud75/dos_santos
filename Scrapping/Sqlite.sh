#!/bin/bash


if [ ! -s Scrap.txt ]; then
    echo "Erreur : le fichier Scrap.txt est vide ou n'existe pas."
    exit 1
fi

# Parcourt chaque URL et extrait les balises title et meta
while IFS= read -r url; do
    # Récupérer le contenu de la page
    content=$(curl -s "$url")

    # Extraire la balise <title>
    title=$(echo "$content" | sed -n 's/.*<title>\(.*\)<\/title>.*/\1/p')

    # Extraire le contenu de la balise <meta name="description">
    meta=$(echo "$content" | sed -n 's/.*<meta[^>]*name="description"[^>]*content="\([^"]*\)".*/\1/p')

    # Insertion dans les tables SQLite
    if [ -n "$title" ]; then
        sqlite3 db.sqlite3 "INSERT INTO title (url, title) VALUES ('$url', '$title');"
    fi

    if [ -n "$meta" ]; then
        sqlite3 db.sqlite3 "INSERT INTO meta (url, meta) VALUES ('$url', '$meta');"
    fi

done < Scrap.txt

echo "Données insérées dans db.sqlite3."
