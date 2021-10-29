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
	if current_ammo > 0 and cooldown.is_stopped() and not player.bomb_presence_trigger.is_area_colliding:
		var pos = Globals.snap_to_tile(body.global_position)
		pos += Globals.TILE_SIZE*Vector2(0.5, 0.5)
		var info = equipment.get_bomb_info()
		info["global_position"] = pos
		var bomb = spawner.spawn_with_info(info)
		player.bombs.append(bomb)
		bomb.connect("exploded", self, "_on_Bomb_exploded")
		cooldown.start()
		current_ammo -= 1

func detonate_bomb():
	if equipment.bomb_remote:
		var bomb_to_detonate = player.bombs.pop_front()
		if bomb_to_detonate:
			bomb_to_detonate.explode()

func _on_Bomb_exploded(bomb):
	recover_ammo()
	var index = player.bombs.find(bomb)
	if index > -1:
		player.bombs.remove(index)

func recover_ammo():
	current_ammo += 1
