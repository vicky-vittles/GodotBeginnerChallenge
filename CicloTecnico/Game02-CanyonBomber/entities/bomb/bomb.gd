extends Area2D

signal restore_ammo()

export (int) var current_ammo = 3
onready var entity_mover = $EntityMover
var player_id : int = 0

func spawn(_id: int, dir: Vector2):
	player_id = _id
	entity_mover.set_direction(dir)

func _physics_process(delta):
	entity_mover.move(delta)

func destroy():
	get_node("shape").set_deferred("disabled", true)
	emit_signal("restore_ammo")
	call_deferred("queue_free")

func _on_area_entered(area):
	if area.is_in_group("block"):
		current_ammo -= 1
		if current_ammo <= 0:
			destroy()
