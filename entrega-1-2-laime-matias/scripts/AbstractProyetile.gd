extends Sprite
class_name Proyectile

signal delete_request(proyectile)

var direction: Vector2

func _ready():
	set_physics_process(false)

func set_starting_values(starting_position: Vector2, mouse_direction: Vector2):
	global_position = starting_position
	direction = mouse_direction
	$Timer.start()
	set_physics_process(true)

func _physics_process(delta):
	position += direction*150*delta


func _on_Timer_timeout():
	emit_signal("delete_request", self)
