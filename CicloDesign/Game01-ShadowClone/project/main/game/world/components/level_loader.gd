extends Node

signal level_started()
signal level_finished()

export (NodePath) var world_path
export (float) var delay_on_level_load = 0.2
onready var world = get_node(world_path)

var has_level_to_load : bool = true
var level_id : int

var level_uuid : int = 0
var level
var timer

func _ready():
	timer = Timer.new()
	timer.wait_time = delay_on_level_load
	timer.one_shot = true
	timer.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(timer)

func _process(delta):
	if not has_level_to_load or not timer.is_stopped():
		return
	has_level_to_load = false
	if level:
		get_node(str(level_uuid)).call_deferred("queue_free")
	if world.LEVEL_SCENES.keys().has(level_id):
		level = world.LEVEL_SCENES[level_id].instance()
		level.connect("level_started", self, "emit_signal", ["level_started"])
		level.connect("level_finished", self, "emit_signal", ["level_finished"])
		level_uuid += 1
		level.name = str(level_uuid)
		level.pause_mode = Node.PAUSE_MODE_STOP
		add_child(level)

func load_level(_level_id, with_delay: bool):
	level_id = _level_id
	has_level_to_load = true
	if with_delay:
		timer.start()
