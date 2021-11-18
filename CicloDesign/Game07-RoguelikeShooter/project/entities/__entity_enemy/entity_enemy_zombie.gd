extends "res://entities/__entity_enemy/__entity_enemy.gd"

export (int) var strength = 1

onready var health = $Health
onready var main_sprite = $Body/graphics/main
onready var seek_behavior = $Body/EntityMover/Seek

func set_strength(_value):
	strength = _value
	health.max_health = Globals.ENEMY_HEALTH_LEVELS[strength]
	health.current_health = Globals.ENEMY_HEALTH_LEVELS[strength]
	body.scale = Globals.ENEMY_STRENGTH_LEVELS[strength]
	main_sprite.polygon_color = Globals.STRENGTH_COLORS[strength]
	seek_behavior.max_force = Globals.ENEMY_MAX_FORCE_LEVELS[strength]

func set_target(_target):
	seek_behavior.set_target(_target)

func _on_Dead_state_entered():
	emit_signal("died")
	queue_free()
