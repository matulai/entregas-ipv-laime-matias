extends Area2D 
signal hit

@export var speed = 400 # velocidad en pixeles/segundos
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta: float) -> void:
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		# para evitar que vaya mas rapido al apretar mas de una tecla, ej: derecha y arriba
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# para evitar que se salga de la pantalla
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "right_left"
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up_down"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
