extends Sprite

onready var cannon: Sprite = $Cannon

var SPEED: int = 300 

var proyectile_container: Node2D

func set_proyectile_container(container: Node2D):
	cannon.proyectile_container = container
	proyectile_container = container 

func _physics_process(delta):
	
	var direction: int = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
	
	position.x += direction * SPEED * delta 
