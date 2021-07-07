extends KinematicBody2D

const WALK_SPEED = 128
const DIR_MAP = {
	0: 0,
	45: 1,
	90: 2,
	135: 3,
	180: 4,
	-135: 5,
	-90: 6,
	-45: 7}

onready var graphics_main = $Graphics/main
onready var animation_player = $AnimationPlayer

var prev_direction = Vector2.ZERO
var direction = Vector2.ZERO
var velocity : Vector2

func _process(delta):
	prev_direction = direction
	direction = Vector2.ZERO
	direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	direction.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		var heading_index = int(rad2deg(direction.angle()))
		animation_player.play("walk_" + str(DIR_MAP[heading_index]))
	else:
		animation_player.stop()

func _physics_process(delta):
	velocity = direction * WALK_SPEED
	velocity = move_and_slide(velocity)

func _on_PickableArea_area_entered(area):
	if area.is_in_group("sound_emitter"):
		area.get_parent().collect()
