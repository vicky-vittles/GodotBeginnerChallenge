tool
extends GTEntity2D

signal activated()
signal deactivated()

const SPRITE_FRAMES = {
	Globals.MECHANISM_TYPES.NORMAL_DOOR: 0,
	Globals.MECHANISM_TYPES.IRON_DOOR: 1,
	Globals.MECHANISM_TYPES.LEVER: 2,
	Globals.MECHANISM_TYPES.BUTTON: 3,
	Globals.MECHANISM_TYPES.PRESSURE_PLATE: 4}

const ANIM_NAMES = {
	Globals.MECHANISM_TYPES.NORMAL_DOOR: "normal_door",
	Globals.MECHANISM_TYPES.IRON_DOOR: "iron_door",
	Globals.MECHANISM_TYPES.LEVER: "lever",
	Globals.MECHANISM_TYPES.BUTTON: "button",
	Globals.MECHANISM_TYPES.PRESSURE_PLATE: "pressure_plate"}

export (Globals.MECHANISM_TYPES) var mechanism_type = Globals.MECHANISM_TYPES.LEVER

onready var button_deactivate_timer = $Timers/ButtonDeactivateTimer
onready var cooldown_timer = $Timers/CooldownTimer
onready var main_sprite = $Body/graphics/main
onready var body_collision_shape = $Body/CollisionShape2D
onready var body_animation_player = $Body/AnimationPlayer

var is_active : bool = false

func _ready():
	body_animation_player.play(ANIM_NAMES[mechanism_type])

func _process(delta):
	if Engine.editor_hint:
		main_sprite.frame = SPRITE_FRAMES[mechanism_type]

func activate():
	if is_active: return
	is_active = true
	main_sprite.frame += main_sprite.hframes
	emit_signal("activated")
	match mechanism_type:
		Globals.MECHANISM_TYPES.NORMAL_DOOR, Globals.MECHANISM_TYPES.IRON_DOOR:
			body_collision_shape.set_deferred("disabled", true)

func deactivate():
	if not is_active: return
	is_active = false
	main_sprite.frame -= main_sprite.hframes
	emit_signal("deactivated")

func _on_Timer_timeout():
	if mechanism_type == Globals.MECHANISM_TYPES.BUTTON:
		deactivate()

func _on_PlayerPresence_grouped_area_entered(area):
	match mechanism_type:
		Globals.MECHANISM_TYPES.NORMAL_DOOR, Globals.MECHANISM_TYPES.PRESSURE_PLATE:
			activate()

func _on_PlayerPresence_grouped_area_exited(area):
	match mechanism_type:
		Globals.MECHANISM_TYPES.PRESSURE_PLATE:
			deactivate()

func _on_DamageHurtbox_effect():
	if cooldown_timer.is_stopped():
		cooldown_timer.start()
		match mechanism_type:
			Globals.MECHANISM_TYPES.LEVER:
				if is_active:
					deactivate()
				else:
					activate()
			Globals.MECHANISM_TYPES.BUTTON:
				activate()
				button_deactivate_timer.start()
