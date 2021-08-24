extends Node2D
class_name GTFloatingText

var label : Label
var tween : Tween

func _ready():
	label = Label.new()
	tween = Tween.new()
	add_child(label)
	add_child(tween)
