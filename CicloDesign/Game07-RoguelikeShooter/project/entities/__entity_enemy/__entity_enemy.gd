extends Entity2D

signal died()

export (Globals.ENEMY_TYPES) var enemy_types

onready var body = $Body
onready var damage_flash = $Body/graphics/damage_flash
onready var entity_mover = $Body/EntityMover
