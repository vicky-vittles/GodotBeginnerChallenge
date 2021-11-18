extends GTState

export (bool) var can_move = true

func enter(_info = null):
	if can_move:
		entity.entity_mover.enable()
	else:
		entity.entity_mover.disable()
