extends GTArea2D

onready var entity_mover = $EntityMover

func _ready():
	entity_mover.set_move_direction(-1)

func _physics_process(delta):
	entity_mover.move(delta)

func destroy(area):
	queue_free()
