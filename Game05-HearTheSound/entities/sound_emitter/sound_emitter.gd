extends Node2D
signal collected()

export (int) var max_distance = 512
export (int) var min_volume_db = -12
export (int) var max_volume_db = 6

onready var light = $Light2D
onready var sprite = $Sprite
onready var main_sound = $MainSound
onready var collected_sound = $CollectedSound
onready var pickable_area_shape = $PickableArea/CollisionShape2D

func _ready():
	main_sound.play()

func adjust_volume_by_target(target_pos: Vector2):
	var dist = global_position.distance_to(target_pos)
	var dist_ratio = (max_distance-dist)/max_distance
	dist_ratio = clamp(dist_ratio, 0.0, 1.0)
	main_sound.volume_db = lerp(min_volume_db, max_volume_db, dist_ratio)

func collect():
	light.visible = false
	sprite.visible = false
	pickable_area_shape.set_deferred("disabled", true)
	main_sound.stop()
	collected_sound.play()
	emit_signal("collected")

func _on_CollectedSound_finished():
	queue_free()
