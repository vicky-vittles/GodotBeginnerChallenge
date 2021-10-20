extends EntityTopdownPlayer

export (int) var max_ammo = 5

var aim_direction : Vector2
var current_ammo : int = max_ammo

onready var rotation_pivot = $Body/graphics/rotation_pivot
onready var dashed_line_indicator = $DashedLineIndicator
onready var boomerang_spawner = $BoomerangSpawner

func _on_MouseController_mouse_position(pos):
	var mouse_global_pos = Globals.get_screen_size()*pos
	aim_direction = body.global_position.direction_to(mouse_global_pos)
	rotation_pivot.look_at(mouse_global_pos)

func fire_boomerang():
	if current_ammo > 0:
		var boomerang = boomerang_spawner.spawn_with_info({
			"global_position": body.global_position,
			"user_body": body})
		boomerang.fire(aim_direction)
		boomerang.connect("collected", self, "_on_Boomerang_collected")
		dashed_line_indicator.add_boomerang(boomerang)
		current_ammo -= 1

func _on_Boomerang_collected(_boomerang):
	current_ammo += 1
	dashed_line_indicator.remove_boomerang(_boomerang)
