extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")
const SAW = preload("uid://hvx68dliwpai")
var timer: float = 0
var goal: float = 2

func _process(delta: float) -> void:
	if(timer > goal):
		var rocket = ROCKET.instantiate()
		var saw = SAW.instantiate()
		add_child(rocket)
		add_child(saw)
		if $Label.timer > 10:
			if randf_range(0, 1) > 0.4:
				var rocket2 = ROCKET.instantiate()
				add_child(rocket2)
		if $Label.timer > 18:
			if randf_range(0, 1) > 0.4:
				var rocket3 = ROCKET.instantiate()
				add_child(rocket3)
		if $Label.timer > 25:
			if randf_range(0, 1) > 0.4:
				var rocket4 = ROCKET.instantiate()
				add_child(rocket4)
			if randf_range(0, 1) > 0.4:
				var rocket42 = ROCKET.instantiate()
				add_child(rocket42)
		if $Label.timer > 35:
			if randf_range(0, 1) > 0.4:
				var rocket5 = ROCKET.instantiate()
				add_child(rocket5)
			if randf_range(0, 1) > 0.4:
				var rocket52 = ROCKET.instantiate()
				add_child(rocket52)
			if randf_range(0, 1) > 0.4:
				var rocket53 = ROCKET.instantiate()
				add_child(rocket53)
		if $Label.timer > 35:
			if randf_range(0, 1) > 0.2:
				var rocket6 = ROCKET.instantiate()
				add_child(rocket6)
			if randf_range(0, 1) > 0.2:
				var rocket62 = ROCKET.instantiate()
				add_child(rocket62)
			if randf_range(0, 1) > 0.2:
				var rocket63 = ROCKET.instantiate()
				add_child(rocket63)
			if randf_range(0, 1) > 0.2:
				var rocket64 = ROCKET.instantiate()
				add_child(rocket64)
		goal = randf_range(2 / (1 + ($Label.timer / 20)), 5 / (1 + ($Label.timer / 40)))
		timer = 0
	timer += delta
