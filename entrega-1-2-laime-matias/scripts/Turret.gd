extends Sprite

onready var fire_position: Position2D = $FirePosition

export (PackedScene) var proyectile_scene: PackedScene

var proyectile_container: Node

var player

func fire():
	var proyectile_instance: Proyectile = proyectile_scene.instance()
	proyectile_container.add_child(proyectile_instance)
	proyectile_instance.set_starting_values(fire_position.global_position, (player.global_position - fire_position.global_position).normalized())
	proyectile_instance.connect("delete_request", self, "on_proyectile_delete_request")

func on_proyectile_delete_request(proyectile):
	proyectile_container.remove_child(proyectile)
	proyectile.queue_free()

func set_values(current_player, current_proyectile_container):
	self.player = current_player
	self.proyectile_container = current_proyectile_container
	$Timer.start()

func _on_Timer_timeout():
	fire()
