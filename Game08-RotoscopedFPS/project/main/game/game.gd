extends Spatial

onready var world = $World

#func _ready():
#	get_node("World/Level/root/map").verify_and_build()
##	var qodot_fgd = load("res://addons/qodot/game_definitions/fgd/qodot_fgd.tres")
##	qodot_fgd.set_export_file(true)

func add_entity(entity):
	world.level.root.map.add_child(entity)
