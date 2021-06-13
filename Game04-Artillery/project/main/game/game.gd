extends Node2D

onready var main_viewport = $root/MainViewport/Viewport
onready var minimap_viewport = $root/MinimapViewport/Viewport
onready var world = $root/MainViewport/Viewport/World
onready var targetted_camera = $root/MainViewport/Viewport/MultitargetCamera

func _ready():
	minimap_viewport.world_2d = main_viewport.world_2d
	targetted_camera.add_target(world.players.get_main_player())

func add_projectile(proj):
	proj.connect("exploded", self, "_on_Projectile_exploded")
	targetted_camera.add_target(proj)
	world.add_projectile(proj)

func _on_Projectile_exploded(proj):
	targetted_camera.remove_target(proj)
	proj.call_deferred("queue_free")
