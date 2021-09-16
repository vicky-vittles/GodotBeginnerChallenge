extends ProgressBar

export (Color) var rect_color = Color.white
var max_size : Vector2

onready var progress = $progress

func _ready():
	get_parent().connect("ready", self, "init")

func init():
	max_size = get_parent().rect_size
	progress.color = rect_color
	progress.rect_size = max_size * Vector2(value / 100.0, 1)

func _on_ProgressBar_value_changed(value):
	progress.rect_size = max_size * Vector2(value / 100.0, 1)
