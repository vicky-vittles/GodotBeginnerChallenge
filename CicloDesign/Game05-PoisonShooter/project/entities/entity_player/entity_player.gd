extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal bomb_caused_damage()
signal ammo_updated(ammo)
signal health_updated(health)
signal took_damage(damage)
signal hurt()
signal died()

onready var health = $Health
onready var poison_bomb_spawner = $PoisonBombs/Spawner
onready var poison_bomb_ammo = $PoisonBombs/Ammo
onready var poison_bomb_cooldown = $PoisonBombs/Cooldown
onready var range_indicator = $Widgets/range_indicator
onready var arrow = $Body/visuals/graphics/juice/arrow

var aim_direction : Vector2

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = Utils.get_screen_size()*pos
	aim_direction = body.global_position.direction_to(mouse_global_pos)
	arrow.look_at(mouse_global_pos)

func _on_DamageHurtbox_took_damage(damage):
	emit_signal("took_damage", damage)

func _on_PoisonBombs_bomb_caused_damage():
	emit_signal("bomb_caused_damage")

func _on_Health_health_updated(current):
	emit_signal("health_updated", current)

func _on_Ammo_points_updated(current):
	emit_signal("ammo_updated", current)
