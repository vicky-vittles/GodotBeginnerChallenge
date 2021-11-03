extends TileMap

const BLANK_TILE : int = 0
const destructible_tiles = {1: 1}
const wall_tiles = [5, 6, 7, 8, 9, 10, 13]

export (NodePath) var _room_path
export (NodePath) var _collectibles_path

onready var sprite_spawner = $SpriteSpawner
onready var tween = $Tween

var room
var explosions_to_check = []

var collectibles

func _ready():
	room = get_node(_room_path)
	collectibles = get_node(_collectibles_path)
	assert(room, "Error initializing RoomBackgroundTilemap: 'room' property is null")
	assert(collectibles, "Error initializing Room: 'collectibles' property is null")

func _physics_process(delta):
	for explosion in explosions_to_check:
		_check_explosion(explosion)
	explosions_to_check.clear()

# Check if explosion hit a destructible tile
func _check_explosion(explosion):
	var world_pos = explosion.global_position
	var local_pos = explosion.global_position-room.global_position
	var tile_pos = world_to_map(local_pos)
	var tile_id = get_cellv(tile_pos)
	if is_destructible_tile_in_pos(world_pos):
		# Set blank tile on position
		set_cellv(tile_pos, BLANK_TILE)
		# Tell explosion that it destroyed a tile
		explosion.destroyed_tile()
		# Spawn an sprite entity to play the destroyed animation
		var sprite = sprite_spawner.spawn_with_info({"global_position": world_pos, "sprite_type": destructible_tiles[tile_id]})
		sprite.play()
		# Notify other components
		collectibles.destroyed_tile(world_pos)

# Lookup for destructible tiles
func is_destructible_tile_in_pos(pos: Vector2) -> bool:
	pos -= room.global_position
	var tile_pos = world_to_map(pos)
	var tile_id = get_cellv(tile_pos)
	for _id in destructible_tiles.keys():
		if tile_id == _id:
			return true
	return false

# Lookup for wall tiles
func is_wall_tile_in_pos(pos: Vector2) -> bool:
	pos -= room.global_position
	var tile_pos = world_to_map(pos)
	var tile_id = get_cellv(tile_pos)
	for _id in wall_tiles:
		if tile_id == _id:
			return true
	return false
