extends AbstractState

func enter() -> void:
	character._play_animation("dead")
	character.dead = true
	character.collision_layer = 0
	character.collision_mask = 0
	
	if character.target != null:
		character._play_animation("idle_alert")
	else:
		character._play_animation("idle")


func _on_animation_finished(anim_name: String) -> void:
	if anim_name in ["idle_alert", "idle"]:
		character._remove()
