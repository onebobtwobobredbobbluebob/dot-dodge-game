extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")
const SAW = preload("uid://hvx68dliwpai")
var timer: float = 0
var goal: float = 2

func _process(delta: float) -> void:
	if(timer > goal):
		var rocket = ROCKET.instantiate()
		var saw = SAW.instantiate()
		$Enemies.add_child(rocket)
		$Enemies.add_child(saw)
		goal = randf_range(2 / (1 + (GameState.timer / 20)), 5 / (1 + (GameState.timer / 40)))
		timer = 0
	timer += delta
