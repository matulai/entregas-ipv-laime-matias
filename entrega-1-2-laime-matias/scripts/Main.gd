extends Node2D

func _ready():
	$Player.set_proyectile_container(self)
	$Turret.set_values($Player, self)
