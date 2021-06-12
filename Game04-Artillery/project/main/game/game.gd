extends Node2D

onready var main_viewport = $root/MainViewport/Viewport
onready var minimap_viewport = $root/MinimapViewport/Viewport
onready var world = $root/MainViewport/Viewport/World

func _ready():
	minimap_viewport.world_2d = main_viewport.world_2d

func add_projectile(proj):
	world.add_projectile(proj)
