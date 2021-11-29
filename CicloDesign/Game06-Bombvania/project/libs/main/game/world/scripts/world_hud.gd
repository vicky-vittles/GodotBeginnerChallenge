extends CanvasLayer

const EMPTY_HEART = 1
const HALF_HEART = 2
const FULL_HEART = 3

onready var hearts = $root/hearts
onready var bombs = $root/bombs

func update_health(health):
	for heart in hearts.get_children():
		heart.frame = EMPTY_HEART
	if health <= 0:
		return
	for i in range(1, health+1):
		var heart_index = int(ceil(float(i)/2.0))-1
		var heart_sprite = FULL_HEART if i % 2 == 0 else HALF_HEART
		hearts.get_child(heart_index).frame = heart_sprite

func update_bombs(current_bombs):
	for bomb in bombs.get_children():
		bomb.visible = false
	for i in range(1, current_bombs+1):
		var bomb_index = i-1
		bombs.get_child(bomb_index).visible = true
