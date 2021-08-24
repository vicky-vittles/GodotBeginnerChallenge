extends Node2D

func stop_pipe():
	get_node("1").entity_mover.freeze()
	get_node("2").entity_mover.freeze()
	get_node("point").entity_mover.freeze()

func destroy(area):
	queue_free()
