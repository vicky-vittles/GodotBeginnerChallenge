extends GTState

func enter(_info = null):
	actor.animation_player.play("die")

func physics_process(delta):
	actor.entity_mover.set_move_direction(Vector2.ZERO)
	actor.entity_mover.move(delta)
