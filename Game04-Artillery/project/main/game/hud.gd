extends CanvasLayer

onready var charge_bar = $root/bottom/charge_bar
#onready var main_viewport = $MainViewport/Viewport
#onready var minimap_viewport = $Minimap/Viewport
#
#func _ready():
#	minimap_viewport.world_2d = main_viewport.world_2d

func _on_Player_charge_updated(amount: float):
	charge_bar.value = 100 * amount
