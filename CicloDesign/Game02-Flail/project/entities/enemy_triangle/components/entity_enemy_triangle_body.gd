extends KinematicBody2D

onready var graphics = $graphics

func orient(direction):
	graphics.rotation = direction.normalized().angle()+PI/2
