extends WindowDialog

var initial_position

func _ready():
	initial_position = self.get_position()
	var btn = get_close_button()
	btn.queue_free()

func _process(delta):
	self.set_position(initial_position)
