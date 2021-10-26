extends GTEntity2D

signal died()

const MOVEMENT_THRESHOLD = 4

export (Color) var healthy_color
export (Color) var poisoned_color
export (float) var strength = 1.0 setget set_strength
export (float) var speed = 1.0 setget set_speed
export (float) var poison_multiplier = 2.0

onready var body = $Body
onready var body_collision_shape = $Body/CollisionShape2D
onready var health = $Health
onready var move_trail = $Body/visuals/graphics/move_trail
onready var main_sprite = $Body/visuals/graphics/rotation_pivot/main
onready var poison_explosion_hitbox = $Body/Triggers/PoisonExplosionHitbox
onready var poison_hurtbox = $Body/Triggers/PoisonHurtbox
onready var entity_mover = $Body/EntityMover
onready var seek_player_behavior = $Body/EntityMover/SeekPlayer
onready var enemy_separation_behavior = $Body/EntityMover/EnemySeparation
onready var enemy_cohesion_behavior = $Body/EntityMover/EnemyCohesion
onready var rotation_pivot = $Body/visuals/graphics/rotation_pivot

var facing_direction : float
var poison_amount : int = 0

func _ready():
	var nodes = get_tree().get_nodes_in_group("entity_player")
	if nodes:
		set_target(nodes[0].body)
	body_collision_shape.set_deferred("disabled", true)

func set_strength(_value):
	strength = _value
	body.scale = Vector2.ONE * strength
	health.max_health *= strength
	health.current_health *= strength

func set_speed(_value):
	speed = _value
	entity_mover.max_speed *= speed

func set_target(_target): seek_player_behavior.set_target(_target)

func _physics_process(delta):
	# Adjust sprite color
	var health_t = float(health.current_health)/float(health.max_health)
	var current_color = lerp(poisoned_color, healthy_color, health_t)
	move_trail.modulate = current_color
	main_sprite.color = current_color
	
	# Adjust sprite orientation
	if entity_mover.velocity.length() > MOVEMENT_THRESHOLD:
		var move_direction = entity_mover.velocity.normalized()
		facing_direction = rad2deg(move_direction.angle())
		rotation_pivot.rotation_degrees = facing_direction

func _on_PoisonHurtbox_grouped_area_entered(area):
	var my_pos = body.global_position
	var explosion_pos = area.body.global_position
	var dist = explosion_pos.distance_to(my_pos)
	var explosion_radius = area.get_child(0).shape.radius + poison_hurtbox.get_child(0).shape.radius
	var percent_damage = 0.5+(1.0-(dist/explosion_radius))/2.0
	var damage_dealt = area.damage*percent_damage
	damage_dealt = int(ceil(damage_dealt))
	
	poison_amount += damage_dealt
	poison_explosion_hitbox.set_damage(poison_multiplier*poison_amount)
	health.lose_health(damage_dealt)

func _on_PoisonTimer_timeout():
	health.lose_health(poison_amount)

func _on_PresenceTrigger_grouped_area_entered(area):
	enemy_separation_behavior.add_agent(area)
	enemy_cohesion_behavior.add_agent(area)

func _on_PresenceTrigger_grouped_area_exited(area):
	enemy_separation_behavior.remove_agent(area)
	enemy_cohesion_behavior.remove_agent(area)

func _on_CollisionEnableTimer_timeout():
	body_collision_shape.set_deferred("disabled", false)
