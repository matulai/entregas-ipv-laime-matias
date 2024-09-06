extends Area2D
class_name enemy

onready var fire_position = $FirePosition
onready var fire_timer = $FireTimer
onready var raycast = $RayCast2D

export (PackedScene) var projectile_scene

var projectile_container

var target: Node2D

func _physics_process(delta):
	if has_target():
		raycast.set_cast_to(target.global_position - fire_position.global_position)
		
		if raycast.is_colliding() :
			fire_timer.set_paused(true)
		else:
			fire_timer.set_paused(false)

func _ready():
	fire_timer.connect("timeout", self, "fire_at_player")
	raycast.set_collision_mask(4)

func initialize(container, turret_pos, projectile_container):
	container.add_child(self)
	global_position = turret_pos
	self.projectile_container = projectile_container

func fire_at_player():
	var proj_instance = projectile_scene.instance()
	proj_instance.initialize(projectile_container, fire_position.global_position, fire_position.global_position.direction_to(target.global_position))


func _on_DetectionArea_body_entered(body):
	target = body
	fire_timer.start()
	set_physics_process(true)

func _on_DetectionArea_body_exited(body):
	if body == target:
		fire_timer.stop()
		set_physics_process(false)
		target = null

func has_target():
	return target != null
