extends Node2D

export (Texture) var destruction_map

onready var quad_tree_root = $Terrain/QuadTreeRoot
onready var terrain_sprite = $Terrain/Graphics/terrain
onready var image_manipulator = $Terrain/ImageManipulator

func _ready():
	image_manipulator.set_image(destruction_map.get_data())
	image_manipulator.draw_circle(Vector2(240, 400), 100, Color.white)
	terrain_sprite.get_material().set_shader_param("destruction_map", image_manipulator.texture)
