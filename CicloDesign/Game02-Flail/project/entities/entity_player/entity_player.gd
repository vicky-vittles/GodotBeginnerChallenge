extends GTEntity2D

signal died()
signal collided()

export (Vector2) var diamond_scale_min = Vector2(0.1, 0.1)
export (Vector2) var diamond_scale_max = Vector2(1.0, 1.0)
export (int) var min_speed_for_damage = 1500

onready var body = $Body
onready var input_controller = $MobileShakeController
onready var entity_mover = $Body/EntityMover

func _on_EntityMover_collided(collision):
	emit_signal("collided", collision)

func _on_Dead_state_entered():
	emit_signal("died")
