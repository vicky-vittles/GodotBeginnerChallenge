extends GTTriggerArea2D

export (NodePath) var destiny_room_path

var destiny_room

func _ready():
	destiny_room = get_node(destiny_room_path)
	assert(destiny_room, "Error initializing RoomTrigger: 'destiny_room' property is null")

func _on_RoomTrigger_effect():
	entity.switched_rooms(destiny_room)
