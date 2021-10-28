extends Node2D

onready var sprite = $Sprite
onready var tween = $Tween

func _ready():
	tween.play(sprite, "position", Vector2(100, 500), Vector2(500, 100), 1.0)
