extends AbstractState

export (int) var dash_frames_amount: int = 5
var current_dash_frame: int = 0

func enter() -> void:
	character.gravity = 0
	character.velocity.y = 0
	character.snap_vector = Vector2.ZERO
	# ver como hacer el dash en la direccion que esta mirando el player actualmente
	character.velocity.x = character.body_pivot.scale.x * character.dash_speed
	character._play_animation("idle")

func exit() -> void:
	character.gravity = 10
	current_dash_frame = 0

func update(delta: float) -> void:
	character._handle_weapon_actions()
	character._apply_movement()
	if current_dash_frame == 5:
		if character.is_on_floor():
			if character.move_direction == 0:
				emit_signal("finished", "idle")
			else:
				emit_signal("finished", "walk")
		else:
			character._play_animation("fall")
			emit_signal("finished", "idle")
	current_dash_frame += 1

# En este callback manejamos, por el momento, solo los impactos
func handle_event(event: String, value = null) -> void:
	match event:
		"hit":
			character._handle_hit(value)
			if character.dead:
				emit_signal("finished", "dead")
