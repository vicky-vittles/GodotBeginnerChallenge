extends GTTriggerArea2D

export (String) var tag

var destiny_room

func set_destiny_room(_destiny):
	destiny_room = _destiny

func _on_RoomTrigger_effect():
	assert(destiny_room, "Error utilizing RoomTrigger: 'destiny_room' property is null")
	if entity.get_parent().name == 'Rooms':
		entity.get_parent().switched_rooms(destiny_room)
