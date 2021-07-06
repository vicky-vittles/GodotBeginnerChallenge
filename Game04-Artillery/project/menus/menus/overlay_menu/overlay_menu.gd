extends GTMenu
signal player_died()
signal update_info(kills, time)

func update_info(kills, time):
	emit_signal("update_info", kills, time)
