extends Node2D

signal collided(info)

export (NodePath) var player_body_path

onready var player_body = get_node(player_body_path)
onready var link = $Link
onready var tip = $Tip
onready var entity_mover = $Tip/EntityMover
onready var visible_timer = $VisibleTimer
onready var cooldown_timer = $CooldownTimer

var can_shoot : bool = true
var flying : bool = false
var camera_position : Vector2
var direction : Vector2

func _ready():
	visible = false

func _physics_process(delta):
	tip.rotation = player_body.global_position.direction_to(tip.global_position).angle()
	link.points = [player_body.global_position-global_position, tip.global_position-global_position]

func fire():
	if flying or not can_shoot:
		return
	flying = true
	can_shoot = false
	visible_timer.start()
	cooldown_timer.start()
	tip.global_position = player_body.global_position
	entity_mover.set_move_direction(direction)
	entity_mover.enable()

func release():
	visible = false

func _on_MouseController_mouse_position(pos):
	var center = get_viewport_rect().size / 2
	direction = center.direction_to(pos)

func _on_EntityMover_collided(result):
	if flying:
		flying = false
		entity_mover.set_move_direction(Vector2.ZERO)
		entity_mover.disable()
		emit_signal("collided", result)

func enable_shoot():
	can_shoot = true
