extends "res://components/level_loader/level_loader.gd"

const DUNGEON_SCENE = preload("res://main/game/world/dungeon/dungeon.tscn")
const DUNGEON_RESOURCE_PATH = "res://main/game/world/dungeon/definitions/dungeon_%s.tres"

func check_load_level():
	if not _has_level_to_load or not _delay_timer.is_stopped():
		return
	_has_level_to_load = false
	if level:
		world.get_node(str(_level_uuid)).call_deferred("queue_free")
	if current_level_id < Globals.DUNGEON_MAX_LEVEL:
		level = DUNGEON_SCENE.instance()
		level.connect("reached_end", world, "clear_dungeon")
		_level_uuid += 1
		level.name = str(_level_uuid)
		level.pause_mode = Node.PAUSE_MODE_STOP
		world.add_child(level)
		world.move_child(level, 0)
		var dungeon_resource = load(DUNGEON_RESOURCE_PATH % [current_level_id])
		level.dungeon_resource = dungeon_resource
		level.player = world.player
		var steps_history = level.generate_dungeon()
		var spawn_point = steps_history[0] * Globals.TILE_SIZE * Vector2.ONE
		level.teleporter_pos = spawn_point + Globals.TILE_SIZE * Vector2.ONE/2
		world.player.global_position = level.teleporter_pos
