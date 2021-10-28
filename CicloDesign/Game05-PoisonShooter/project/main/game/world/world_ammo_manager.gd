extends GTRandomPointZone2D

onready var spawner = $Spawner
onready var pre_spawn_timer = $PreSpawnTimer

var ammo_to_spawn : int = 0

func spawn_ammo():
	var rand_pos = random_point()
	spawner.spawn_with_pos(rand_pos)
	ammo_to_spawn -= 1
	if ammo_to_spawn > 0:
		pre_spawn_timer.start()

func _on_Player_shot_bomb():
	ammo_to_spawn += 1
	if pre_spawn_timer.is_stopped():
		pre_spawn_timer.start()
