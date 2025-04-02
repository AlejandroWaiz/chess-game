extends Sprite2D

const TEXTURE_HOLDER = preload("res://scenes/texture_holder.tscn")

const BLACK_BISHOP = preload("res://scripts/Chess/black_bishop.png")
const BLACK_KING = preload("res://scripts/Chess/black_king.png")
const BLACK_KNIGHT = preload("res://scripts/Chess/black_knight.png")
const BLACK_PAWN = preload("res://scripts/Chess/black_pawn.png")
const BLACK_QUEEN = preload("res://scripts/Chess/black_queen.png")
const BLACK_ROOK = preload("res://scripts/Chess/black_rook.png")
const WHITE_BISHOP = preload("res://scripts/Chess/white_bishop.png")
const WHITE_KING = preload("res://scripts/Chess/white_king.png")
const WHITE_KNIGHT = preload("res://scripts/Chess/white_knight.png")
const WHITE_PAWN = preload("res://scripts/Chess/white_pawn.png")
const WHITE_QUEEN = preload("res://scripts/Chess/white_queen.png")
const WHITE_ROOK = preload("res://scripts/Chess/white_rook.png")

const TURN_WHITE = preload("res://scripts/Chess/turn-white.png")
const TURN_BLACK = preload("res://scripts/Chess/turn-black.png")

const PIECE_MOVE = preload("res://scripts/Chess/Piece_move.png")

var pieces_movement = preload("res://scenes/movement.gd")
var movement = pieces_movement.new()


@onready var pieces = $Pieces
@onready var dots = $Dots
@onready var turn = $Turn

# -6 Black king , -5 Black queen , -4 Black rook , -3 Black bishop , -2 Black knight , -1 Black pawn 
#  6 White king ,  5 White queen ,  4 White rook ,  3 White bishop ,  2 White knight ,  1 White pawn 

var board : Array 
var white : bool = true
var state : bool = false
var moves = []
var selected_piece : Vector2

func _ready():
	board.append([4,2,3,5,6,3,2,4])
	board.append([1,1,1,1,1,1,1,1])
	board.append([0,0,0,0,0,0,0,0])
	board.append([0,0,0,0,0,0,0,0])
	board.append([0,0,0,0,0,0,0,0])
	board.append([0,0,0,0,0,0,0,0])
	board.append([-1,-1,-1,-1,-1,-1,-1,-1])
	board.append([-4,-2,-3,-5,-6,-3,-2,-4])
	print("displaying")
	display_board()
	
func _input(event):
	if event is InputEventMouseButton && event.is_pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if is_mouse_out(): return 
			var var1 = snapped(get_global_mouse_position().x, 0) / Global.CELL_WIDTH 
			var var2 = abs(snapped(get_global_mouse_position().y, 0)) / Global.CELL_WIDTH 
			if !state && (white && board[var2][var1] > 0 || !white && board[var2][var1] < 0):
				selected_piece = Vector2(var2,var1)
				show_options()
				state = true
				
				
func is_mouse_out():
	if get_global_mouse_position().x < 0 || get_global_mouse_position().x > 144 || get_global_mouse_position().y > 0 || get_global_mouse_position().x < -144 : return true
	return false
	
			

func display_board():
	for i in Global.BOARD_SIZE:
		for j in Global.BOARD_SIZE:
			var holder = TEXTURE_HOLDER.instantiate()
			pieces.add_child(holder)
			holder.global_position = Vector2(j * Global.CELL_WIDTH + (Global.CELL_WIDTH / 2), -i * Global.CELL_WIDTH - (Global.CELL_WIDTH / 2))
			
			match board[i][j]:
				-6: holder.texture = BLACK_KING
				-5: holder.texture = BLACK_QUEEN
				-4: holder.texture = BLACK_ROOK
				-3: holder.texture = BLACK_BISHOP
				-2: holder.texture = BLACK_KNIGHT
				-1: holder.texture = BLACK_PAWN
				0: holder.texture =	 null
				6: holder.texture = WHITE_KING
				5: holder.texture = WHITE_QUEEN
				4: holder.texture = WHITE_ROOK
				3: holder.texture = WHITE_BISHOP
				2: holder.texture = WHITE_KNIGHT
				1: holder.texture = WHITE_PAWN


func show_options():
	moves = get_moves(white, board, selected_piece)
	if moves == []:
		print("moves empty")
		state = false
		return
	show_dots()
	
func show_dots():
	for i in moves:
		var holder = TEXTURE_HOLDER.instantiate()
		dots.add_child(holder)
		holder.texture = PIECE_MOVE
		holder.global_position = Vector2(i.y * Global.CELL_WIDTH + (Global.CELL_WIDTH / 2), -i.x * Global.CELL_WIDTH - (Global.CELL_WIDTH / 2))
	
	
func get_moves(is_white: bool, board: Array, selected_piece: Vector2): 
	var _moves = []
	match abs(board[selected_piece.x][selected_piece.y]):
		1: _moves = movement.get_pawn_moves(board, selected_piece, is_white)
		2: _moves = movement.get_knigth_moves(board, selected_piece, is_white)
		3: _moves = movement.get_bishop_moves(board, selected_piece, is_white)
		4: _moves = movement.get_rook_moves(board, selected_piece, is_white)
		5: _moves = movement.get_queen_moves(board, selected_piece, is_white)
		6: _moves = movement.get_king_moves(board, selected_piece, is_white)
	
	return _moves
		

	

	
