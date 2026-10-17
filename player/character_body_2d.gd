extends CharacterBody2D

func _process(delta: float) -> void:
	position.y = lerp(position.y, get_local_mouse_position().y, 1 - pow(0.005, delta))
	position.x = lerp(position.x, get_local_mouse_position().x, 1 - pow(0.005, delta))
	if position.y < 0:
		position.y = 0
	if position.y > GameState.CENTER.y * 2:
		position.y = GameState.CENTER.y * 2
	if position.x < 0:
		position.x = 0
	if position.x > GameState.CENTER.x * 2:
		position.x = GameState.CENTER.x * 2	
