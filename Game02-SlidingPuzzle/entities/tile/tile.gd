extends Area2D

signal pressed_tile(tile_id)

onready var tween = $Tween
var tile_id : int
var is_mouse_colliding : bool = false

func init(_tile_id):
	tile_id = _tile_id
	get_node("Graphics/main").frame = tile_id

func _process(delta):
	if is_mouse_colliding and Input.is_action_just_pressed("click"):
		emit_signal("pressed_tile", tile_id)

func move_to(dest_id: int, dest_pos: Vector2):
	tween.interpolate_property(self, "global_position",global_position, dest_pos, 0.2)
	tween.start()


func set_is_mouse_colliding(_value):
	is_mouse_colliding = _value
