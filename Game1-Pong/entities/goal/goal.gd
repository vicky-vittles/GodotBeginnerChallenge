extends Area2D

signal goal(paddle_id)

export (int) var paddle_id

func _on_body_entered(body):
	if body.is_in_group("ball"):
		emit_signal("goal", paddle_id)
