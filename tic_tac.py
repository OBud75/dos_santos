game = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

game[0][0] = "X"
game[1][0] = "X"
game[2][0] = "X"
row_1 = game [0]
row_2 = game [1]
row_3 = game [2]
three_in_a_row = [
	(row_1[0], row_1[1], row_1[2]),
	(row_2[0], row_2[1], row_2[2]),
	(row_3[0], row_3[1], row_3[2]),
	(row_1[0], row_2[0], row_3[0]),
	(row_1[1], row_2[1], row_3[1]),
	(row_1[2], row_2[2], row_3[2]),
	(row_1[0], row_2[1], row_3[2]),
	(row_1[2], row_2[1], row_3[0])
]

def is_a_win(player):
	return any([
		all([cell == player for cell in row])
		for row in three_in_a_row])

print(is_a_win("X"))
