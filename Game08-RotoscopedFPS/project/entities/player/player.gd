extends KinematicBody

export (float, 0.0, 1.0) var mouse_sensitivity = 0.15

onready var weapon = $weapon
onready var entity_mover = $EntityMover
onready var input_controller = $PlayerController
onready var camera = $Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= mouse_sensitivity * event.relative.x
		camera.rotation_degrees.x -= mouse_sensitivity * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -89, 89)

func jump():
	entity_mover.turn_off_snap()
	entity_mover.jump()

func shoot():
	weapon.shoot(-transform.basis.z, -camera.global_transform.basis.z)
