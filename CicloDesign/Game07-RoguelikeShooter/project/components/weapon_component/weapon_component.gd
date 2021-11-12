extends Node2D

export (Resource) var resource
export (String) var projectile_group
export (NodePath) var spawn_position_path
export (int) var number_of_bullets = 1
export (float) var bullet_spacing = 15.0
export (int) var bullet_size = 1
export (int) var bullet_speed = 1

onready var projectile_spawner = $ProjectileSpawner
onready var cooldown_timer = $CooldownTimer

var spawn_position

func _ready():
	spawn_position = get_node(spawn_position_path)
	assert(resource, "Error initializing WeaponComponent: 'resource' is null")
	assert(resource is ComponentWeaponResource, "Error initializing WeaponComponent: 'resource' is not a ComponentWeaponResource")
	assert(spawn_position, "Error initializing WeaponComponent: 'spawn_position' is null")
	projectile_spawner._entity_template = resource.projectile
	cooldown_timer.wait_time = resource.cooldown_time

func shoot(direction):
	if cooldown_timer.is_stopped():
		var starting_angle = -(number_of_bullets-1)*bullet_spacing/2
		for i in number_of_bullets:
			var angle = deg2rad(starting_angle+(i*bullet_spacing))
			var angled_direction = direction.rotated(angle)
			var offset_position = spawn_position.global_position - global_position
			var angled_position = global_position + offset_position.rotated(angle)
			spawn_bullet(angled_direction, angled_position)

func spawn_bullet(direction, pos):
	var proj = projectile_spawner.spawn_with_pos(pos)
	proj.set_bullet_size(bullet_size)
	proj.set_bullet_speed(bullet_speed)
	proj.shoot(direction)
	proj.add_to_group(projectile_group)
	cooldown_timer.start()
