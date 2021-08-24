extends "res://entities/enemies/_enemy.gd"

signal died()

export (float) var MOVE_SPEED = 0.25

onready var entity_mover = $BitEntityMover
onready var grace_timer = $GraceTimer
onready var animation_player = $AnimationPlayer

var future_pos : Vector2
var can_move : bool = false

func _ready():
	grace_timer.start()
	animation_player.play("walk")

func _physics_process(delta):
	if can_move:
		future_pos = entity_mover.move(-MOVE_SPEED, collision_map)
		global_position = lerp(global_position, future_pos, 0.5)
	else:
		entity_mover.fall()

func die():
	emit_signal("died")
	queue_free()

func _on_Hurtbox_area_entered(area):
	if area.is_in_group("explosion"):
		animation_player.play("die")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "die":
		die()

func _on_GraceTimer_timeout():
	can_move = true
