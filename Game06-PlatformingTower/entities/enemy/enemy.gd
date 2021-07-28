extends Area2D

signal player_entered()

export (Vector2) var move_direction = Vector2(0, 0)

onready var character_mover = $CharacterMover

func _physics_process(delta):
	character_mover.set_move_direction(move_direction.x)
	character_mover.move(delta)

func _on_Enemy_body_entered(body):
	if not body.is_in_group("player"):
		move_direction.x *= -1

func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("player_entered")
