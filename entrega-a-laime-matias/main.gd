extends Node

@export var enemy_scene: PackedScene
var score

func _game_over() -> void:
	$DeathSound.play()
	$Music.stop()
	$ScoreTimer.stop()
	$EnemyTimer.stop()
	$HUD.show_game_over()

func new_game():
	$Music.play()
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()


func _on_start_timer_timeout() -> void:
	$EnemyTimer.start()
	$ScoreTimer.start()
	$HUD.update_score(score)
	
func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)
	
func _on_enemy_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var enemy = enemy_scene.instantiate()

	# Choose a random location on Path2D.
	var enemy_spawn_location = $EnemyPath/EnemySpawnLocation
	enemy_spawn_location.progress_ratio = randf()

	# Set the enemy's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation + PI / 2

	# Set the enemy's position to a random location.
	enemy.position = enemy_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	enemy.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(enemy)


func _on_hud_start_game() -> void:
	new_game()
