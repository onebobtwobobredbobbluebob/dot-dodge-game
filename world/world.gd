extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")
var timer: float = 0
var goal: float = 2

func _process(delta: float) -> void:
	if(timer > goal):
		var rocket = ROCKET.instantiate()
		add_child(rocket)
		goal = randf_range(2, 5)
		timer = 0
	timer += delta
