extends Sprite

onready var fire_position: Position2D = $FirePosition

export (PackedScene) var proyectile_scene: PackedScene

var proyectile_container: Node

func _physics_process(_delta):
	var mouse_position = get_global_mouse_position()

	var direction = mouse_position - global_position
	
	rotation = direction.angle()

func fire():
	var proyectile_instance: Proyectile = proyectile_scene.instance()
	proyectile_container.add_child(proyectile_instance)
	proyectile_instance.set_starting_values(fire_position.global_position, (fire_position.global_position - global_position).normalized())
	proyectile_instance.connect("delete_request", self, "on_proyectile_delete_request")

func on_proyectile_delete_request(proyectile):
	proyectile_container.remove_child(proyectile)
	proyectile.queue_free()
