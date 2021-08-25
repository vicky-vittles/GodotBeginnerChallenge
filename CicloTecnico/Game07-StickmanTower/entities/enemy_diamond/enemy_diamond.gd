extends GTTeleporter2D
class_name EnemyDiamond

export (Vector2) var move_direction = Vector2(1,0)
export (int) var move_speed = 128
export (float) var time_to_invert_direction = 1.0

onready var entity_mover = $EntityMover
onready var invert_direction_timer = $InvertDirectionTimer

func _ready():
	invert_direction_timer.wait_time = time_to_invert_direction
	invert_direction_timer.start()
	entity_mover.RUN_SPEED = move_speed

func _physics_process(delta):
	entity_mover.set_move_direction(move_direction)
	entity_mover.move(delta)

func invert_direction():
	move_direction *= -1
