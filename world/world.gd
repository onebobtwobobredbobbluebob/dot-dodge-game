extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")
const SAW = preload("uid://hvx68dliwpai")
const HEAL = preload("uid://bb25hrqjtx7yw")
const LASER = preload("uid://d1ulw7nutlcgd")
const COIN = preload("uid://dbi12jt85ok7w")


var timer: float = 0
var timer2: float = 0
var timer3: float = 0
var timer4: float = 0
var timer5: float = 0
var goal: float = 4
var goal2: float = 30
var goal3: float = 22
var goal4: float = 55
var goal5: float = 15

func _process(delta: float) -> void:
	if timer > goal:
		add_item(ROCKET, round(randf_range(1, 1 + (GameState.timer / 40))))
		goal = randf_range(2 / (1 + (GameState.timer / 20)), 7 / (1 + (GameState.timer / 40)))
		timer = 0
	
	if timer2 > goal2:
		add_item(HEAL, 1)
		goal2 = randf_range(14, 26)
		timer2 = 0
		
	if timer3 > goal3:
		add_item(SAW, min(round(randf_range(1, 1 + (GameState.timer / 60))), 3))
		goal3 = randf_range(max(5 / (1 + (GameState.timer / 20)), 1.5), max(10 / (1 + (GameState.timer / 40)), 3))
		timer3 = 0
		
	if timer4 > goal4:
		add_item(LASER, min(round(randf_range(1, 1 + ((GameState.timer - 60) / 60))), 3))
		goal4 = randf_range(10, 40)
		timer4 = 0
		
	if timer5 > goal5:
		add_item(COIN, min(round(randf_range(1, max(1 + ((GameState.timer - 40) / 50), 1))), 3))
		goal5 = randf_range(max(25 / (1 + (GameState.timer / 60)), 6), max(30 / (1 + ((GameState.timer - 60) / 80)), 10))
		timer5 = 0

	timer += delta
	timer2 += delta
	timer3 += delta
	timer4 += delta
	timer5 += delta

func add_item(ITEM: PackedScene, amount: int):
	for i in range(amount):
		var item = ITEM.instantiate()
		$Enemies.add_child(item)
