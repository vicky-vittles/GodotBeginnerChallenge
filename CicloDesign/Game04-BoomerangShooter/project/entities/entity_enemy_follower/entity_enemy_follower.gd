extends GTEntity2D

signal died()

onready var body = $Body
onready var body_collision_shape = $Body/CollisionShape
onready var health = $Health
onready var damage_hurtbox = $Body/Triggers/DamageHurtbox
onready var see_ahead_raycast = $Body/SeeAheadRaycast
onready var entity_mover = $Body/EntityMover

var speed : float = 1.0 setget _set_speed # Speed multiplier
var target setget _set_target

#func _ready():
#	yield(get_tree().create_timer(1.0), "timeout")
#	body_collision_shape.disabled = false

func _physics_process(delta):
	var direction = entity_mover.velocity.normalized()
	if direction != Vector2.ZERO:
		body.rotation = direction.normalized().angle()

func _set_speed(_value):
	speed = _value
	get_node("Body/EntityMover").max_speed *= speed
	get_node("Body/EntityMover").max_force *= speed

func _set_target(_value):
	target = _value
	entity_mover.set_target(target)

func _on_Dead_state_entered():
	emit_signal("died")
