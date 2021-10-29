extends Node

export (NodePath) var _player_path
export (NodePath) var _body_path
export (NodePath) var _equipment_path
var player
var body
var equipment

onready var spawner = $Spawner
onready var cooldown = $Cooldown

var current_ammo : int = 1

func _ready():
	player = get_node(_player_path)
	body = get_node(_body_path)
	equipment = get_node(_equipment_path)
	current_ammo = equipment.ammo
	assert(player != null, "Error initializing EntityPlayerBombManager: 'player' property is null")
	assert(body != null, "Error initializing EntityPlayerBombManager: 'body' property is null")
	assert(equipment != null, "Error initializing EntityPlayerBombManager: 'equipment' property is null")

func place_bomb():
	if current_ammo > 0 and cooldown.is_stopped():
		var pos = Globals.snap_to_tile(body.global_position)
		pos += Globals.TILE_SIZE*Vector2(0.5, 0.5)
		var info = equipment.get_bomb_info()
		info["global_position"] = pos
		var bomb = spawner.spawn_with_info(info)
		bomb.connect("exploded", self, "recover_ammo")
		cooldown.start()
		current_ammo -= 1

func recover_ammo():
	current_ammo += 1
