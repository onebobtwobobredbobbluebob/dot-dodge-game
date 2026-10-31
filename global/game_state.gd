extends Node

const CENTER = Vector2(640, 360)
var camera: Camera2D
var player: CharacterBody2D
var alive: bool
var timer: float = 0
var coins: int
var total_coins: int

func _process(delta: float) -> void:
	timer += delta

func start_game():
	timer = 0
	coins = 0
	
