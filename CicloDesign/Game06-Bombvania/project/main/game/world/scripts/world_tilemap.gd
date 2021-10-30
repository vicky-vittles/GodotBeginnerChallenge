extends TileMap

signal destroyed_tile(pos)

const BLANK_TILE : int = 0

export (Dictionary) var destructible_tiles = {}

onready var sprite_spawner = $SpriteSpawner
onready var tween = $Tween

var explosions_to_check = []

func _physics_process(delta):
	for explosion in explosions_to_check:
		var world_pos = explosion.global_position
		var tile_pos = world_to_map(world_pos)
		var tile_id = get_cellv(tile_pos)
		if is_destructible_tile_in_pos(world_pos):
			set_cellv(tile_pos, BLANK_TILE)
			explosion.destroyed_tile()
			var sprite = sprite_spawner.spawn_with_info({"global_position": world_pos, "sprite_type": destructible_tiles[tile_id]})
			sprite.play()
			emit_signal("destroyed_tile", world_pos)
	explosions_to_check.clear()

func is_destructible_tile_in_pos(pos: Vector2) -> bool:
	var tile_pos = world_to_map(pos)
	var tile_id = get_cellv(tile_pos)
	for _id in destructible_tiles.keys():
		if tile_id == _id:
			return true
	return false
