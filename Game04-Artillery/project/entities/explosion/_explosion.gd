extends Node2D

signal faded()

export (int) var MIN_DAMAGE
export (int) var MAX_DAMAGE

onready var damage_hurtbox = $DamageHurtbox
onready var fade_timer = $FadeTimer

func init(circle: Array):
	var collision_shape = CollisionShape2D.new()
	damage_hurtbox.add_child(collision_shape)
	collision_shape.global_position = circle[0]
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = circle[1]
	collision_shape.shape = circle_shape
	
	fade_timer.start()

func _on_FadeTimer_timeout():
	emit_signal("faded", self)
