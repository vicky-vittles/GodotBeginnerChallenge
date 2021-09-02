extends GTEntity2D

signal died()

var targets
export (float) var max_speed = 128
export (float) var max_force = 64

onready var body = $Body
onready var entity_mover = $Body/EntityMover
onready var graphics = $Body/graphics

func _on_EntityMover_tree_entered():
	get_node("Body/EntityMover").target = targets[0]
	get_node("Body/EntityMover").MAX_SPEED = max_speed
	get_node("Body/EntityMover").MAX_FORCE = max_force

func _on_TargetManager_tree_entered():
	get_node("TargetManager").targets = targets

func _on_Dead_died():
	emit_signal("died", self)
