extends KinematicBody

export (bool) var can_shoot = true

onready var entity_mover = $EntityMover
onready var animation_player = $AnimationPlayer
var move_direction : Vector2
