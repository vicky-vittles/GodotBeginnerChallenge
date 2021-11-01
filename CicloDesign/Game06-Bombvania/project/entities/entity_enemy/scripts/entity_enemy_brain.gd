extends Node

signal updated_move_direction(dir)

export (NodePath) var _entity_path
export (NodePath) var _raycasts_path

var entity
var cardinal_directions = []

func _ready():
	entity = get_node(_entity_path)
	var raycasts = get_node(_raycasts_path)
	assert(entity != null, "Error initializing EntityEnemyBrain: 'entity' property is null")
	assert(raycasts != null, "Error initializing EntityEnemyBrain: 'raycasts' property is null")
	cardinal_directions = {
		Vector2.RIGHT: [raycasts.get_child(0), false, 0],
		Vector2.UP: [raycasts.get_child(1), false, 1],
		Vector2.LEFT: [raycasts.get_child(2), false, 2],
		Vector2.DOWN: [raycasts.get_child(3), false, 3]}

func _physics_process(delta):
	var collision_number = 0
	# Poll input
	for direction in cardinal_directions.keys():
		var raycast = cardinal_directions[direction][0]
		cardinal_directions[direction][1] = raycast.is_colliding()
		if cardinal_directions[direction][1]:
			collision_number += 1
	# Enemy movement code
	for direction in cardinal_directions.keys():
		match entity.enemy_type:
			Globals.ENEMY_TYPES.BLOB:
				turnaround(direction)
			Globals.ENEMY_TYPES.KNIGHT:
				corner_turn(direction, collision_number)
				turnaround(direction)
	#entity.body.global_position = Globals.snap_to_tile(entity.body.global_position)

func turnaround(direction):
	if entity.move_direction == direction and cardinal_directions[direction][1] and entity.turnaround_timer.is_stopped():
		entity.move_direction *= -1
		emit_signal("updated_move_direction", entity.move_direction)
		entity.turnaround_timer.start()

func corner_turn(direction, collision_number):
	if collision_number == 0 and entity.turnaround_timer.is_stopped():
		var new_offset = (cardinal_directions[direction][2] + 1+2*(randi()%2))%4
		var current_index = cardinal_directions.keys().find(entity.move_direction)
		entity.move_direction = cardinal_directions.keys()[(current_index+new_offset)%4]
		emit_signal("updated_move_direction", entity.move_direction)
		entity.turnaround_timer.start()

func _on_Move_state_entered():
	emit_signal("updated_move_direction", entity.move_direction)
