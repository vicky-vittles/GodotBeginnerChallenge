extends GTEntity2D

signal died()

onready var health = $Health
onready var damage_hurtbox = $Body/Triggers/DamageHurtbox
onready var entity_mover = $Body/EntityMover

var target setget set_target

func set_target(_value):
	target = _value
	entity_mover.set_target(target)

func _on_Dead_state_entered():
	emit_signal("died")
