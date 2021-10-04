extends GTEntity2D

onready var health = $Health
onready var damage_hurtbox = $Body/Triggers/DamageHurtbox
onready var entity_mover = $Body/EntityMover

func set_target(target):
	entity_mover.set_target(target)
