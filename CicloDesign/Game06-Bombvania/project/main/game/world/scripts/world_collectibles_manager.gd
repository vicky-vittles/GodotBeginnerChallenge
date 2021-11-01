extends Node2D

const DESTRUCTIBLE_TILE_TABLE = {
	Globals.COLLECTIBLE_TYPES.HEART: 0.1}
const MAX_MONEY : int = 3

onready var spawner = $Spawner

func destroyed_tile(pos):
	yield(get_tree().create_timer(0.4), "timeout")
	var rand_heart_chance = randf() < DESTRUCTIBLE_TILE_TABLE[Globals.COLLECTIBLE_TYPES.HEART]
	var rand_money = randi() % (MAX_MONEY + 1)
	var diamonds = floor(rand_money/Globals.MONEY_DIAMOND)
	var coins = rand_money - Globals.MONEY_DIAMOND*diamonds
	
	if rand_heart_chance:
		var info = {
			"global_position": pos,
			"collectible_type": Globals.COLLECTIBLE_TYPES.HEART}
		spawner.spawn_with_info(info)
	
	for i in coins:
		var info = {
			"global_position": pos,
			"collectible_type": Globals.COLLECTIBLE_TYPES.MONEY_COIN}
		spawner.spawn_with_info(info)
	
	for i in diamonds:
		var info = {
			"global_position": pos,
			"collectible_type": Globals.COLLECTIBLE_TYPES.MONEY_DIAMOND}
		spawner.spawn_with_info(info)
