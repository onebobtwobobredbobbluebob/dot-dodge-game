extends Node2D


func _process(delta: float) -> void:
	position = lerp(position, GameState.player.position, 1 - pow(0.0000000000000001, delta))
