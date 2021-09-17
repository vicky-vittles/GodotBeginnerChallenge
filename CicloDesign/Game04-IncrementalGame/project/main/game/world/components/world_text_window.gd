extends VBoxContainer

const UI_LABEL = preload("res://components/ui/ui_label/ui_label.tscn")

export (int) var start_fade_at = 4
export (int) var max_labels = 10

onready var labels = $labels

func create_text(message: String):
	var current_labels = labels.get_child_count()
	if current_labels >= max_labels:
		var label_to_remove = labels.get_child(max_labels-1)
		label_to_remove.queue_free()
	var new_label = UI_LABEL.instance()
	new_label.text = message
	new_label.autowrap = true
	labels.add_child(new_label)
	labels.move_child(new_label, 0)
	
	for i in range(start_fade_at, max_labels):
		if i+1 <= labels.get_child_count():
			labels.get_child(i).modulate = Color(1.0, 1.0, 1.0, 0.75*float(max_labels-i+1)/float(max_labels))
