extends State

onready var MOVE = $"../Move"
var soldier

func enter(_info):
	soldier = fsm.actor
	soldier.graphics.play("idle")

func process(_delta):
	soldier.input_controller.clear_input()
	soldier.input_controller.get_input()

func physics_process(delta):
	var dir = soldier.input_controller.move_direction
	var aim = soldier.input_controller.aim_direction
	
	if dir != Vector2.ZERO:
		fsm.change_state(MOVE)
	
	soldier.bit_entity_mover.fall(delta)
	soldier.change_aim(aim, delta)
	soldier.charge_power(soldier.input_controller.charge_hold, soldier.input_controller.charge_released, delta)
