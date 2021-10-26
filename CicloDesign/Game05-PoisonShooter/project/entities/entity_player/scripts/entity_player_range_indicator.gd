extends "res://components/dashed_line_drawer_2d/dashed_line_drawer_2d.gd"

export (NodePath) var _entity_path
export (NodePath) var _body_path

var entity : Node
var body : Node
var bombs = []

func _ready():
	entity = get_node(_entity_path)
	body = get_node(_body_path)
	assert(entity != null, "Error initializing EntityPlayerRangeIndicator: 'entity' property is null")
	assert(body != null, "Error initializing EntityPlayerRangeIndicator: 'body' property is null")

func _draw():
	for bomb in bombs:
		var player_pos = body.global_position-entity.global_position
		var bomb_pos = bomb.body.global_position-entity.global_position
		draw_dashed_line(player_pos, bomb_pos)

func add_bomb(bomb):
	bombs.append(bomb)

func remove_bomb(bomb):
	var i = bombs.find(bomb)
	bombs.remove(i)
