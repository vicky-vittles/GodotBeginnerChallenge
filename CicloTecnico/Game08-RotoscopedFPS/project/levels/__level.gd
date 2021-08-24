extends Spatial

signal killed_zombie()
signal checkpoint_reached(point)

export (String) var level_name
export (bool) var load_on_start = true
onready var checkpoint_file_path = "user://"+level_name+"-checkpoint.save"

onready var root = $root
onready var entities = $entities

var level_info = {}
var entity_count = []
var total_enemies_to_kill : int

func _ready():
	for entity_type in Globals.ENTITIES:
		entity_count.append(0)
	for entity in entities.get_children():
		if "entity_type" in entity:
			entity_count[entity.entity_type] += 1
			
			if entity.entity_type == Globals.ENTITIES.ENEMY_ZOMBIE:
				entity.connect("died", self, "emit_signal", ["killed_zombie"])
	total_enemies_to_kill = entity_count[Globals.ENTITIES.ENEMY_ZOMBIE]
