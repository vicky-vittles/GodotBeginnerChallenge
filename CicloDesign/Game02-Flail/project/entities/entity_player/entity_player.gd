extends GTEntity2D

signal died()
signal collided()

export (int) var min_speed_for_damage = 1500

onready var body = $Body
onready var debug_controller = $DebugController
onready var input_controller = $MobileShakeController
onready var entity_mover = $Body/EntityMover

func _on_EntityMover_collided(collision):
	emit_signal("collided", collision)

func _on_Dead_state_entered():
	emit_signal("died")
