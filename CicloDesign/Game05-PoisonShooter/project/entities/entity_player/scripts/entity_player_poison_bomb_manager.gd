extends Node

signal shot_bomb()
signal bomb_caused_damage()

export (NodePath) var _entity_path
export (NodePath) var _body_path
export (NodePath) var _range_indicator_path

onready var spawner = $Spawner
onready var ammo = $Ammo
onready var cooldown = $Cooldown

var entity : Node2D
var body : Node2D
var range_indicator : Node2D

func _ready():
	entity = get_node(_entity_path)
	body = get_node(_body_path)
	range_indicator = get_node(_range_indicator_path)
	assert(entity != null, "Error initializing EntityPlayerPoisonBombManager: 'entity' property is null")
	assert(body != null, "Error initializing EntityPlayerPoisonBombManager: 'body' property is null")
	assert(range_indicator != null, "Error initializing EntityPlayerPoisonBombManager: 'range_indicator' property is null")

func shoot_bomb():
	if ammo.current_points > 0 and cooldown.is_stopped():
		var info = {
			"global_position": body.global_position}
		var bomb = spawner.spawn_with_info(info)
		bomb.shoot(entity.aim_direction)
		bomb.connect("caused_damage", self, "emit_signal", ["bomb_caused_damage"])
		bomb.connect("exploded", self, "_on_PoisonBomb_exploded")
		range_indicator.add_bomb(bomb)
		ammo.lose_points(1)
		cooldown.start()
		emit_signal("shot_bomb")

func _on_PoisonBomb_exploded(bomb):
	range_indicator.remove_bomb(bomb)
	ammo.gain_points(1)
