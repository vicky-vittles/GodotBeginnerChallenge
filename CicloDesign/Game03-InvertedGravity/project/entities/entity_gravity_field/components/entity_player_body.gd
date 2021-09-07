extends GTArea2D

onready var field_sprite = $graphics/color/field_sprite

func set_direction(direction):
	field_sprite.material.set_shader_param("direction", Vector2(0.0, -direction))
