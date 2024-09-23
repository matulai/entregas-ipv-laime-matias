extends AbstractEnemyState

func enter() -> void:
	character.velocity = Vector2.ZERO
	_fire()

func _fire() -> void:
	character._fire()
	character._play_animation("attack")

func update(delta) -> void:
	character._look_at_target()

func _on_animation_finished(anim_name: String) -> void:
	if character.target == null:
		emit_signal("finished", "idle")
	else:
		match anim_name:
			"attack":
				character._play_animation("alert")
			"alert":
				if character._can_see_target():
					_fire()
				else:
					emit_signal("finished", "idle")

func _handle_body_exited(body: Node) -> void:
	._handle_body_exited(body)
	
	if character.target != null:
		if character.get_current_animation() != "attack":
			emit_signal("finished", "idle")
