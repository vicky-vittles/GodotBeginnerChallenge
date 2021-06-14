extends CanvasLayer

onready var charge_bar = $root/bottom/charge_bar

func _on_Player_charge_updated(amount: float):
	charge_bar.value = 100 * amount
