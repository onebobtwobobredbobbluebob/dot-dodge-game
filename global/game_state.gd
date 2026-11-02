extends Node

const CENTER = Vector2(640, 360)
var camera: Camera2D
var player: CharacterBody2D
var alive: int
var timer: float = 0
var coins: int
var total_coins: int = 15000
var player_max_health: int = 100
var heal_spawn_rate: int = 14
var speed: bool = false
var chance_of_deflecting: int = 0

func _process(delta: float) -> void:
	timer += delta

func start_game():
	timer = 0
	coins = 0
	alive = 1
	
