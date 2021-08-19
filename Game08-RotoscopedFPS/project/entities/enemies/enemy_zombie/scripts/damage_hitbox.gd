extends GTArea3D

export (int) var DAMAGE = 10

func _on_grouped_area_entered(area):
	if area.has_method("hurt"):
		area.hurt(DAMAGE, null)
