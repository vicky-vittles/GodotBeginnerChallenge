extends Node

signal updated_move_direction(dir)

export (NodePath) var _entity_path
export (NodePath) var _raycasts_path

var entity
var raycasts
var cardinal_directions = [
	[Vector2.RIGHT],
	[Vector2.UP],
	[Vector2.LEFT],
	[Vector2.DOWN]]

func _ready():
	entity = get_node(_entity_path)
	raycasts = get_node(_raycasts_path)
	assert(entity != null, "Error initializing EntityEnemyBrain: 'entity' property is null")
	assert(raycasts != null, "Error initializing EntityEnemyBrain: 'raycasts' property is null")
	for i in range(0, 4):
		var raycast = raycasts.get_child(i)
		cardinal_directions[i].append(raycast)

func _on_Move_state_entered():
	emit_signal("updated_move_direction", entity.move_direction)

func _on_EntityMover_collided(result):
	if entity.enemy_type == Globals.ENEMY_TYPES.BLOB and entity.turnaround_timer.is_stopped():
		entity.move_direction *= -1
		emit_signal("updated_move_direction", entity.move_direction)
		entity.turnaround_timer.start()

func change_direction():
	if entity.enemy_type == Globals.ENEMY_TYPES.KNIGHT:
		var rand_index = randi() % 4
		entity.move_direction = cardinal_directions[rand_index][0]
		emit_signal("updated_move_direction", entity.move_direction)
		entity.change_direction_timer.start()

func _on_Health_health_lost(current, lost):
	if entity.enemy_type == Globals.ENEMY_TYPES.KNIGHT:
		change_direction()
		entity.change_direction_timer.stop()
		entity.change_direction_timer.wait_time /= 2
		entity.change_direction_timer.start()
