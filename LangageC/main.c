#include <stdio.h>
#include <stdlib.h>
#include "joueur.h"

void clear_screen() {
    printf("\033[H\033[J");
}

int main() {
	int height = 5, width = 5;
	Map* map = get_map(height, width);
	load_blocks(map);

	// Create player and set initial position to the top-left corner
	Player player;
	player.position = &map->blocks[1][1];

	// Example moves
	//move(&player, 'r');  // Move right
	//move(&player, 'b');  // Move down
	
	printf("%d %d\n", (*player.position).pos_x, (*player.position).pos_y);


	show_player(map, &player);

	char direction;
	int running = 1;
	while (running) {
		printf("Enter direction to move (t=up, h=right, g=down, f=left, q=quit): ");
		scanf(" %c", &direction);
		// Ici vous lisez uniquement le premier char, du coup le reste du buffer d'input
		// n'est pas vidé. Pour éviter cela on peut soit itérer sur le reste du buffer
		// avec getchar, soit (et on préfèrera souvent cette solution), utiliser
		// fgets pour lire l'input (et donc vider le buffer) et prendre le premier char renvoyé.
		// Vu l'exercice, on peut penser à désactiver le mode canonique afin d'envoyer immédiatement
		// chaque touche au programme dès qu'elle est tapée (cf bibliotheque termios)
		if (direction == 'q') {
			running = 0;
		}
		else {
			clear_screen();
			move(&player, direction);
			show_player(map, &player);
		}
	}

  free_map(map);
	return 0;
}
