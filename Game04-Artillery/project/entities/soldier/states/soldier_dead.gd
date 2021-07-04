extends State

var soldier

func enter(_info):
	soldier = fsm.actor
	soldier.graphics.play("die")
