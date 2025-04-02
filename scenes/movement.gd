extends Sprite2D

func get_pawn_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var direction
	var is_first_move 
	if is_white: direction = Vector2(1,0)
	else: direction = Vector2(-1,0)

	if is_white && selected_piece.x == 1 || !is_white && selected_piece.x == 6: is_first_move = true
	
	var pos = selected_piece + direction
	if is_empty(board, pos): _moves.append(pos)
	
	pos = selected_piece + Vector2(direction.x , 1)
	if is_valid_position(pos):
		if is_enemy(board, pos, is_white): _moves.append(pos)
		
	pos = selected_piece + Vector2(direction.x,-1)
	
	if is_valid_position(pos):
		if is_enemy(board, pos, is_white): _moves.append(pos);
		
	pos = selected_piece + direction * 2
	if is_first_move && is_empty(board, pos) && is_empty(board, (selected_piece + direction)): _moves.append(pos)
		
		
	return _moves	
	
		


func get_knigth_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var directions = [Vector2(2,1), Vector2(2,-1),Vector2(1,2),Vector2(-1,2), Vector2(-2,1), Vector2(-2,-1),Vector2(-1,2),Vector2(-1,-2)]
	
	for i in directions:
		var pos = selected_piece
		pos += i
		if is_valid_position(pos):
			if is_empty(board, pos): _moves.append(pos)
			elif is_enemy(board, pos, is_white):
				_moves.append(pos)
			
	return _moves	
	
func get_bishop_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var directions = [Vector2(1,1), Vector2(1,-1),Vector2(-1,1),Vector2(-1,-1)]
	
	for i in directions:
		var pos = selected_piece
		pos += i 
		while is_valid_position(pos):
			if is_empty(board, pos): _moves.append(pos)
			elif is_enemy(board, pos, is_white):
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves
	
func get_rook_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var directions = [Vector2(0,1), Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]
	
	for i in directions:
		var pos = selected_piece
		pos += i 
		while is_valid_position(pos):
			if is_empty(board, pos): _moves.append(pos)
			elif is_enemy(board, pos, is_white):
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves	
	
func get_queen_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var directions = [Vector2(1,1), Vector2(1,-1),Vector2(-1,1),Vector2(-1,-1), Vector2(0,1), Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]
	
	for i in directions:
		var pos = selected_piece
		pos += i 
		while is_valid_position(pos):
			if is_empty(board, pos): _moves.append(pos)
			elif is_enemy(board, pos, is_white):
				_moves.append(pos)
				break
			else: break
			
			pos += i
	return _moves	
	
func get_king_moves(board: Array, selected_piece: Vector2, is_white: bool):
	var _moves = []
	var directions = [Vector2(1,1), Vector2(1,-1),Vector2(-1,1),Vector2(-1,-1), Vector2(0,1), Vector2(0,-1),Vector2(1,0),Vector2(-1,0)]
	
	for i in directions:
		var pos = selected_piece
		pos += i 
		if is_valid_position(pos):
			if is_empty(board, pos): _moves.append(pos)
			elif is_enemy(board, pos, is_white):
				_moves.append(pos)
			
			
	return _moves
	
func is_valid_position(pos: Vector2):
	if pos.x >= 0 && pos.x < Global.BOARD_SIZE && pos.y >= 0 && pos.y < Global.BOARD_SIZE: return true
	return false  
 
func is_empty(board: Array, pos: Vector2):
	if board[pos.x][pos.y] == 0: return true
	return false 
	
func is_enemy(board:Array, pos: Vector2, is_white: bool):
	if is_white && board[pos.x][pos.y] < 0 || !is_white && board[pos.x][pos.y] > 0: return true
	return false
