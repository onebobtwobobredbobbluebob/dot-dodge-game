extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")
const SAW = preload("uid://hvx68dliwpai")
const HEAL = preload("uid://bb25hrqjtx7yw")

var timer: float = 0
var timer2: float = 0
var goal: float = 2
var goal2: float = 5

func _process(delta: float) -> void:
	if timer > goal:
		var rocket = ROCKET.instantiate()
		var saw = SAW.instantiate()
		$Enemies.add_child(rocket)
		$Enemies.add_child(saw)
		goal = randf_range(2 / (1 + (GameState.timer / 20)), 5 / (1 + (GameState.timer / 40)))
		timer = 0

	if timer2 > goal2:
		var heal = HEAL.instantiate()
		$Enemies.add_child(heal)
		#goal2 = randf_range(10, 40)
		#timer2 = 0

	timer += delta
	timer2 += delta
