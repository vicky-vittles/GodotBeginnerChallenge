extends GTState

onready var CHASE = $"../Chase"
onready var MISSILE = $"../Missile"
onready var DEAD = $"../Dead"
var previous_state

func enter(info = null):
	previous_state = info["previous_state"]
	actor.animation_player.play("hurt")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "hurt":
		if not actor.health.is_alive:
			fsm.change_state(DEAD)
		elif previous_state != MISSILE:
			fsm.change_state(previous_state)
		else:
			fsm.change_state(CHASE)
