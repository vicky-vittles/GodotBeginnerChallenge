extends Node
class_name LevelLoader

signal level_started()
signal level_finished()

export (NodePath) var world_path
export (float) var delay_on_level_load = 0.2
onready var world = get_node(world_path)

var has_level_to_load : bool = true # Whether or not this script should load a level in _process
var current_level_id : int # The id of the current level

var level_uuid : int = 0 # Unique id for level node name (independent of level id)
var level : Node # The node with the current level loaded
var delay_timer : Timer # Delay timer for level loading

func _ready():
	assert(world != null, "%s has no world set" % [self.name])
	assert("LEVEL_SCENES" in world, "%s world property has no LEVEL_SCENES property" % [self.name])
	delay_timer = Timer.new()
	delay_timer.wait_time = delay_on_level_load
	delay_timer.one_shot = true
	delay_timer.pause_mode = Node.PAUSE_MODE_PROCESS
	add_child(delay_timer)

func _process(delta):
	if not has_level_to_load or not delay_timer.is_stopped(): return
	has_level_to_load = false
	if level:
		get_node(str(level_uuid)).call_deferred("queue_free")
	if world.LEVEL_SCENES.keys().has(current_level_id):
		level = world.LEVEL_SCENES[current_level_id].instance()
		level.connect("level_started", self, "emit_signal", ["level_started"])
		level.connect("level_finished", self, "emit_signal", ["level_finished"])
		level_uuid += 1
		level.name = str(level_uuid)
		level.pause_mode = Node.PAUSE_MODE_STOP
		add_child(level)

func load_level(_current_level_id, with_delay: bool):
	current_level_id = _current_level_id
	has_level_to_load = true
	if with_delay:
		delay_timer.start()
