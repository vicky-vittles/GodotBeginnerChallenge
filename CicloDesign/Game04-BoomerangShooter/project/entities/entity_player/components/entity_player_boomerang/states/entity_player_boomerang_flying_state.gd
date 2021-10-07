extends GTState

signal started_returning()
signal catched_by_player()
signal exited_screen()

var is_returning : bool
var tried_releasing : bool

func enter(_info = null):
	# Reset variables
	is_returning = false
	tried_releasing = false
	actor.body.scale = actor.min_boomerang_size*Vector2.ONE
	# Teleport to player's position
	actor.body.global_position = actor.player.body.global_position
	# Set move_direction
	actor.go_entity_mover.set_move_direction(actor.move_direction, actor.go_entity_mover.move_acceleration_time)

func physics_process(delta):
	if not is_returning and tried_releasing:
		turn_around()
	# Animate body size
	var body_delta = (actor.max_boomerang_size-actor.min_boomerang_size)/(2*actor.go_entity_mover.move_acceleration_time)
	actor.body.scale += body_delta*Vector2.ONE*delta
	actor.body.scale.x = clamp(actor.body.scale.x, actor.min_boomerang_size, actor.max_boomerang_size)
	actor.body.scale.y = clamp(actor.body.scale.y, actor.min_boomerang_size, actor.max_boomerang_size)
	# Rotate according to speed
	var velocity = actor.go_entity_mover.velocity if actor.go_entity_mover.is_enabled else actor.return_entity_mover.velocity
	var current_rotation_speed = lerp(actor.min_rotation_speed, actor.max_rotation_speed, velocity.length()/float(actor.go_entity_mover.max_move_speed))
	actor.rotation_pivot.rotate(current_rotation_speed*delta*PI/180.0)

func calculate_return_direction() -> Vector2:
	# Starting variables
	var player_pos = actor.player.body.global_position
	var boomerang_pos = actor.body.global_position
	var current_direction = boomerang_pos.direction_to(player_pos)
	var offset_angle = Globals.rand_sign()*lerp(actor.min_return_angle, actor.max_return_angle, actor.flight_timer.time_left/actor.flight_timer.wait_time)
	#var rand_angle = Globals.rand_sign()*rand_range(actor.min_return_angle, actor.max_return_angle)
	return current_direction.rotated(deg2rad(offset_angle))

func turn_around():
	tried_releasing = true
	if fsm.current_state == self and not is_returning and actor.minimum_flight_timer.is_stopped():
		is_returning = true
		actor.turnaround_timer.stop()
		actor.go_entity_mover.set_move_direction(Vector2.ZERO)
		# Calculate new boomerang direction
		actor.move_direction = calculate_return_direction()
		# Set move_direction
		actor.return_entity_mover.set_move_direction(actor.move_direction)
		emit_signal("started_returning")

func _on_CatchTrigger_effect():
	if fsm.current_state == self:
		emit_signal("catched_by_player")

func _on_VisibilityNotifier_screen_exited():
	if fsm.current_state == self and is_returning:
		emit_signal("exited_screen")
