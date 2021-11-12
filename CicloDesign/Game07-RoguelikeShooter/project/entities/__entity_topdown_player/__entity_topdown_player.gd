extends Entity2D

onready var input_controller = $InputController
onready var weapon = $Body/Weapon
onready var body = $Body
onready var entity_mover = $Body/EntityMover

var aim_direction : Vector2
