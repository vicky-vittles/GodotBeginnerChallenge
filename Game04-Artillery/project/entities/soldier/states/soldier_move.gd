extends State

onready var IDLE = $"../Idle"
var soldier

func enter(_info):
	soldier = fsm.actor
	soldier.graphics.play("move")

func process(_delta):
	soldier.input_controller.clear_input()
	soldier.input_controller.get_input()

func physics_process(delta):
	var dir = soldier.input_controller.move_direction
	var aim = soldier.input_controller.aim_direction
	
	if dir == Vector2.ZERO:
		fsm.change_state(IDLE)
	
	soldier.graphics.orient(dir.x)
	soldier.bit_entity_mover.set_move_direction(dir)
	soldier.bit_entity_mover.move(delta)
	soldier.bit_entity_mover.fall()
	soldier.change_aim(aim, delta)
	soldier.charge_power(soldier.input_controller.charge_hold, soldier.input_controller.charge_released, delta)
