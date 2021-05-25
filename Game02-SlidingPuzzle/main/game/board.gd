extends Node2D

const WORLD_SIZE = Vector2(400, 400)
const BOARD_SIZE = Vector2(4, 4)
const TILE = preload("res://entities/tile/tile.tscn")
onready var MAX_ID : int = BOARD_SIZE.x * BOARD_SIZE.y

const TILE_DIRECTIONS = [
	Vector2(1, 0),
	Vector2(-1, 0),
	Vector2(0, 1),
	Vector2(0, -1)]
var tiles = []
var solved_tiles = []
var missing_tile_id : int


func _ready():
	randomize()
	create_board()
	remove_one_tile()
	shuffle(10)

func create_board():
	for i in BOARD_SIZE.y:
		for j in BOARD_SIZE.x:
			var tile = TILE.instance()
			var tile_id = Globals.pos_to_id(Vector2(j,i), BOARD_SIZE)
			add_child(tile)
			tile.name = str(tile_id)
			tile.position = Vector2(j,i) * WORLD_SIZE/BOARD_SIZE
			tile.init(int(tile_id))
			tile.connect("pressed_tile", self, "pressed_tile")
			
			tiles.append(int(tile_id))
			solved_tiles.append(int(tile_id))

func remove_one_tile():
	var tile_to_remove = randi() % MAX_ID
	tiles[tile_to_remove] = -1
	missing_tile_id = tile_to_remove
	
	get_node(str(tile_to_remove)).queue_free()

func shuffle(max_moves: int):
	var empty_tile = missing_tile_id
	var empty_pos = Vector2()
	var last_move = 0
	
	for i in max_moves:
		empty_pos = Globals.id_to_pos(empty_tile, BOARD_SIZE)
		
		var available_directions = []
		for dir in TILE_DIRECTIONS:
			var rand_offset = empty_pos + dir
			var rand_id = Globals.pos_to_id(rand_offset, BOARD_SIZE)
			if rand_id != last_move and rand_id >= 0 and rand_id < MAX_ID and Globals.is_valid_pos(rand_offset, BOARD_SIZE):
				available_directions.append(dir)
		
		var rand_dir = available_directions[randi() % available_directions.size()]
		var rand_tile = Globals.pos_to_id(empty_pos + rand_dir, BOARD_SIZE)
		var new_empty_pos = Globals.get_pos(rand_tile, tiles)
		pressed_tile(rand_tile)
		
		last_move = empty_tile
		empty_tile = new_empty_pos


func pressed_tile(tile_id):
	var tile_index = Globals.get_pos(tile_id, tiles)
	var tile_pos = Globals.id_to_pos(tile_index, BOARD_SIZE)
	
	for direction in TILE_DIRECTIONS:
		var offset_pos = tile_pos + direction
		var offset_id = Globals.pos_to_id(offset_pos, BOARD_SIZE)
		if offset_id >= 0 and offset_id < MAX_ID and Globals.is_valid_pos(offset_pos, BOARD_SIZE):
			if tiles[offset_id] == -1:
				tiles[offset_id] = tile_id
				tiles[tile_index] = -1
				var new_pos = position+(offset_pos*WORLD_SIZE/BOARD_SIZE)
				
				var tile_node = get_node(str(tile_id))
				tile_node.move_to(offset_id, new_pos)

func is_solved() -> bool:
	for i in tiles.size():
		if i == missing_tile_id and int(tiles[i]) != -1:
			return false
		if i != missing_tile_id and tiles[i] != i:
			return false
	return true
