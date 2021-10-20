extends GTState

signal took_damage()

onready var hurt_transition = $ToHurt

func _on_DamageHurtbox_grouped_area_entered(area):
	#var boomerang_direction = area.body.actor.move_direction
	#var plane_normal = boomerang_direction.tangent()
	#var plane_origin = area.body.global_position.length()
	#var distance_to_plane = plane_normal.dot(actor.global_position) - plane_origin
	
	#var direction = sign(distance_to_plane)*plane_normal
	var direction = Utils.rand_direction()
	hurt_transition.set_info({"direction": direction})
	emit_signal("took_damage")
