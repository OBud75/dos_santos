#!/usr/bin/env python3
import random

# Initialisation de la grille de jeu
game = [[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]]

def is_a_win(player):
    """Vérifie si le joueur a gagné."""
    row_1 = game[0]
    row_2 = game[1]
    row_3 = game[2]
    return any([
        all([cell == player for cell in row])
        for row in [
            (row_1[0], row_1[1], row_1[2]),  # Ligne 1
            (row_2[0], row_2[1], row_2[2]),  # Ligne 2
            (row_3[0], row_3[1], row_3[2]),  # Ligne 3
            (row_1[0], row_2[0], row_3[0]),  # Colonne 1
            (row_1[1], row_2[1], row_3[1]),  # Colonne 2
            (row_1[2], row_2[2], row_3[2]),  # Colonne 3
            (row_1[0], row_2[1], row_3[2]),  # Diagonale \
            (row_1[2], row_2[1], row_3[0])   # Diagonale /
        ]
    ])

def turn(player):
    """Tour d'un joueur."""
    # Affiche la grille
    for row in game:
        print(row)
    print()

    # Vérifie si un joueur a gagné
    if is_a_win("X"):
        print("X a gagné !")
        quit()
    if is_a_win("O"):
        print("O a gagné !")
        quit()

    # Recherche un emplacement vide et joue
    for _ in range(10):  # Limite les tentatives pour éviter une boucle infinie
        x = random.randrange(3)
        y = random.randrange(3)
        if game[x][y] == " ":
            game[x][y] = player
            # Passe au joueur suivant
            next_player = "O" if player == "X" else "X"
            turn(next_player)
            return

# Lancement de la partie
turn("X")
