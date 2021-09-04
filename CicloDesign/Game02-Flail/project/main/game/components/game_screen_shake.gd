extends GTScreenShake2D

func shake_with_collision(collision):
	var shake_direction = -collision.normal
	shake_simple(16.0, 0.2, 0.1, shake_direction)
