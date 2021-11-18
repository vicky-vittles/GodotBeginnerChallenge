extends Entity2D

export (int) var strength = 1
export (int) var max_entities = 4

var current_entities : int = 0
var player

onready var enemy_spawner = $EnemySpawner
onready var pickup_spawner = $PickupSpawner
onready var main_sprite = $Body/graphics/main

func _ready():
	main_sprite.polygon_color = Globals.STRENGTH_COLORS[strength]

func spawn():
	if current_entities < max_entities:
		current_entities += 1
		var _entity = enemy_spawner.spawn_with_pos(global_position)
		_entity.set_strength(strength)
		_entity.set_target(player.body)
		_entity.connect("died", self, "_on_entity_died")

func _on_entity_died():
	current_entities -= 1

func _on_Health_died():
	var pickup = pickup_spawner.spawn_with_pos(global_position)
	var types = Globals.PICKUP_TYPES.values()
	types.shuffle()
	pickup.set_pickup_type(types.pop_front())
