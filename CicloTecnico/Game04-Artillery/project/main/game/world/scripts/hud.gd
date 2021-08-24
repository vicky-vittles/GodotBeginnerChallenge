extends CanvasLayer

signal update_time_label(time)
signal update_kills_label(kills)

onready var angle_label = $root/bottom/row/vbox/angle_label
onready var charge_bar = $root/bottom/row/vbox2/charge_bar
#onready var previous_charge_bar = $root/bottom/previous_charge_bar

func _on_Player_angle_updated(degrees):
	angle_label.text = str(degrees).pad_decimals(1).pad_zeros(2)

func _on_Player_charge_updated(amount: float):
	charge_bar.value = 100 * amount

func _on_Player_weapon_shoot(angle, charge, dir):
	#previous_charge_bar.value = 100 * charge
	pass

func _on_World_update_time(timer):
	emit_signal("update_time_label", [Utils.get_timer_formatted(timer)])

func _on_World_update_kills(kills):
	emit_signal("update_kills_label", [kills])
