extends "res://entities/Projectile.gd"

func _on_Area2D_area_entered(area):
	call_deferred("_remove")
	area.queue_free()

func _ready():
	$Area2D.collision_mask = 2
	$Area2D.collision_layer = 2
