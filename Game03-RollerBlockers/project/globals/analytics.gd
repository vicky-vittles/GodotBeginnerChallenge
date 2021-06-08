extends Node

var data = {
	"total_playtime": 0, #In seconds
	"level_playtimes": {
		1: 0,
		2: 0,
		3: 0
	},
	"total_deaths": 0,
	"level_deaths": {
		1: 0,
		2: 0,
		3: 0
	}
}

func set_total_playtime(value: int):
	data["total_playtime"] = value

func set_level_playtime(level_id: int, value: int):
	data["level_playtimes"][level_id] = value

func set_total_deaths(value: int):
	data["total_deaths"] = value

func set_level_deaths(level_id: int, value: int):
	data["level_deaths"][level_id] = value
