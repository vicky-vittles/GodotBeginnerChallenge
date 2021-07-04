extends State

onready var DEAD = $"../Dead"
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
	var weapon = soldier.input_controller.weapon_selected
	
	soldier.graphics.orient(dir.x)
	soldier.bit_entity_mover.fall()
	soldier.weapon_selector.switch_weapon(weapon)
	soldier.change_aim(aim, delta)
	soldier.charge_power(soldier.input_controller.charge_hold, soldier.input_controller.charge_released, delta)


func _on_Soldier_hurt():
	if fsm.current_state == self:
		fsm.change_state(DEAD)
