extends "res://entities/__entity_topdown_player/__entity_topdown_player.gd"

signal fired_weapon()

export (NodePath) var _camera_path
export (bool) var weapon_fire_torrent = true
export (int) var player_strength = 1
export (int) var player_speed = 1
export (int) var player_health = 1

onready var mouse_controller = $MouseController
onready var health = $Health
onready var rotation_pivot = $Body/graphics/rotation_pivot

func _ready():
	if _camera_path:
		var camera = get_node(_camera_path)
		mouse_controller.current_camera = camera
	set_player_strength(player_strength)
	set_player_speed(player_speed)
	set_player_health(player_health)

func _on_MouseController_updated_global_position(pos):
	aim_direction = body.global_position.direction_to(pos)
	rotation_pivot.look_at(pos)

func _on_fired_shot():
	emit_signal("fired_weapon")

func set_player_strength(_value):
	player_strength = _value
	weapon.set_bullet_strength(player_strength)

func set_player_speed(_value):
	player_speed = _value
	entity_mover.move_speed = Globals.PLAYER_SPEED_LEVELS[player_speed]
	entity_mover.max_speed = Globals.PLAYER_SPEED_LEVELS[player_speed]

func set_player_health(_value):
	player_health = _value
	health.max_health = Globals.PLAYER_HEALTH_LEVELS[player_health]
	health.set_health(Globals.PLAYER_HEALTH_LEVELS[player_health])

func _on_PresenceTrigger_grouped_area_entered(area):
	match area.entity.pickup_type:
		Globals.PICKUP_TYPES.PLUS_PLAYER_STRENGTH:
			set_player_strength(player_strength+1)
		Globals.PICKUP_TYPES.PLUS_PLAYER_SPEED:
			set_player_speed(player_speed+1)
		Globals.PICKUP_TYPES.PLUS_PLAYER_HEALTH:
			set_player_health(player_health+1)
		Globals.PICKUP_TYPES.PLUS_WEAPON_BULLETS:
			weapon.set_number_of_bullets(weapon.number_of_bullets+1)
		Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_SIZE:
			weapon.set_bullet_size(weapon.bullet_size+1)
		Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_SPEED:
			weapon.set_bullet_speed(weapon.bullet_speed+1)
		Globals.PICKUP_TYPES.PLUS_WEAPON_BULLET_FIRE_SPEED:
			weapon.set_bullet_fire_speed(weapon.bullet_fire_speed+1)
