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
		add_item(ROCKET, 1)
		add_item(SAW, 1)
		goal = randf_range(2 / (1 + (GameState.timer / 20)), 5 / (1 + (GameState.timer / 40)))
		timer = 0

	if timer2 > goal2:
		var heal = HEAL.instantiate()
		$Enemies.add_child(heal)
		goal2 = randf_range(14, 20)
		timer2 = 0

	timer += delta
	timer2 += delta

func add_item(ITEM: PackedScene, amount: int):
	for i in range(amount):
		var item = ITEM.instantiate()
		$Enemies.add_child(item)
