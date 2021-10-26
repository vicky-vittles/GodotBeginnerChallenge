extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal died()

onready var poison_bomb_spawner = $PoisonBombs/Spawner
onready var poison_bomb_ammo = $PoisonBombs/Ammo
onready var poison_bomb_cooldown = $PoisonBombs/Cooldown
onready var range_indicator = $Widgets/range_indicator
onready var arrow = $Body/visuals/graphics/arrow

var aim_direction : Vector2

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = Utils.get_screen_size()*pos
	aim_direction = body.global_position.direction_to(mouse_global_pos)
	arrow.look_at(mouse_global_pos)
