extends Node2D

const ROCKET = preload("uid://bjiycc2ry3noy")

func _process(delta: float) -> void:
	var rocket = ROCKET.instantiate()
	rocket.global_position = Vector2(randf_range(-GameState.CENTER.x, GameState.CENTER.x), -GameState.CENTER.y)
	add_child(rocket)
