extends "res://entities/Projectile.gd"

func _on_Area2D_body_entered(body):
	if body is Player:
		call_deferred("_remove")
		body.queue_free()
		
func _ready():
	$Area2D.collision_mask = 1
	$Area2D.collision_layer = 1
