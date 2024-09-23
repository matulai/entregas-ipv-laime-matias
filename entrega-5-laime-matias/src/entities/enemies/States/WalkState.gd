extends AbstractEnemyState

export (Vector2) var wander_radius: Vector2
export (float) var speed: float
export (float) var max_speed: float

export (float) var pathfinding_step_threshold: float = 5.0

var path: Array = []

func enter() -> void:
	if character.pathfinding != null:
		var random_point: Vector2 =(
			character.global_position +
			Vector2(
				rand_range(-wander_radius.x, wander_radius.x),
				rand_range(-wander_radius.y, wander_radius.y)
			)
		)
		path = character.pathfinding.get_simple_path(
			character.global_position,
			random_point
		)
		if path.empty() || path.size() == 1:
			#print("walk_finished")
			emit_signal("finished", "idle")
		else:
			if character.target != null:
				#print("playing_walk_alert_animation")
				character._play_animation("walk_alert")
			else:
				#print("playing_walk_animation")
				character._play_animation("walk")
	else:
		emit_signal("finished", "idle")

func exit() -> void:
	path = []

func update(delta: float) -> void:
	if character._can_see_target():
		emit_signal("finished", "alert")
		return
	
	var next_point: Vector2 = path.front()
	
	while character.global_position.distance_to(next_point) < pathfinding_step_threshold:
		path.pop_front()
		
		if path.empty():
			emit_signal("finished", "idle")
			return
		
		next_point = path.front()
	character.velocity = (
		character.velocity +
		character.global_position.direction_to(next_point) * speed
	).clamped(max_speed)
	character._apply_movement()
	character.body_anim.flip_h = character.velocity.x < 0
