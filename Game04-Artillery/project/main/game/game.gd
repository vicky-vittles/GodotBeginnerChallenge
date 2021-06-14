extends Node2D

onready var main_viewport = $root/MainViewport/MainViewport
onready var minimap_viewport = $root/MinimapViewport/Minimap
onready var world = $root/MainViewport/MainViewport/World
onready var targetted_camera = $root/MainViewport/MainViewport/MultitargetCamera

func _ready():
	minimap_viewport.world_2d = main_viewport.world_2d
	targetted_camera.add_target(world.players.get_main_player())

func add_projectile(proj):
	#proj.connect("exploded", self, "_on_Projectile_exploded")
	targetted_camera.add_target(proj)
	world.add_projectile(proj)

func _on_World_projectile_exploded(proj, explosions):
	if proj.explosion_nodes.size() > 0:
		var explosion_node = proj.explosion_nodes[0]
		explosion_node.connect("faded", self, "_on_Explosion_faded")
		targetted_camera.add_target(explosion_node)
	targetted_camera.remove_target(proj)
	proj.call_deferred("queue_free")

func _on_Explosion_faded(explosion):
	targetted_camera.remove_target(explosion)
	explosion.call_deferred("queue_free")
