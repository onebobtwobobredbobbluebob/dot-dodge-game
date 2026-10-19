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
		if GameState.timer > 10:
			if randf_range(0, 1) > 0.4:
				var rocket2 = ROCKET.instantiate()
				$Enemies.add_child(rocket2)
		if GameState.timer > 18:
			if randf_range(0, 1) > 0.4:
				var rocket3 = ROCKET.instantiate()
				$Enemies.add_child(rocket3)
		if GameState.timer > 25:
			if randf_range(0, 1) > 0.4:
				var rocket4 = ROCKET.instantiate()
				$Enemies.add_child(rocket4)
			if randf_range(0, 1) > 0.4:
				var rocket42 = ROCKET.instantiate()
				$Enemies.add_child(rocket42)
		if GameState.timer > 35:
			if randf_range(0, 1) > 0.4:
				var rocket5 = ROCKET.instantiate()
				$Enemies.add_child(rocket5)
			if randf_range(0, 1) > 0.4:
				var rocket52 = ROCKET.instantiate()
				$Enemies.add_child(rocket52)
			if randf_range(0, 1) > 0.4:
				var rocket53 = ROCKET.instantiate()
				$Enemies.add_child(rocket53)
		if GameState.timer > 35:
			if randf_range(0, 1) > 0.2:
				var rocket6 = ROCKET.instantiate()
				$Enemies.add_child(rocket6)
			if randf_range(0, 1) > 0.2:
				var rocket62 = ROCKET.instantiate()
				$Enemies.add_child(rocket62)
			if randf_range(0, 1) > 0.2:
				var rocket63 = ROCKET.instantiate()
				$Enemies.add_child(rocket63)
			if randf_range(0, 1) > 0.2:
				var rocket64 = ROCKET.instantiate()
				$Enemies.add_child(rocket64)
		goal = randf_range(2 / (1 + (GameState.timer / 20)), 5 / (1 + (GameState.timer / 40)))
		timer = 0
	timer += delta
