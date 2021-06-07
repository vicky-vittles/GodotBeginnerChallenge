extends CanvasLayer

const level_label_template = "Level %s"

onready var level_label = $root/level_label

func update_level_label(level_id):
	level_label.text = level_label_template % str(level_id).pad_zeros(2)
