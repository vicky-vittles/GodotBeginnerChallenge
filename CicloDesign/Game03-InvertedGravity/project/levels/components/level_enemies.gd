extends Node2D

export (NodePath) var actor_path
onready var actor = get_node(actor_path)

onready var gravity_fields = $GravityFields

func _on_Level_ready():
	for field in gravity_fields.get_children():
		actor.player.connect("inverted_gravity", field, "set_direction")
