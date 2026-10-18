extends CharacterBody2D

func _ready() -> void:
	GameState.player = self

func _process(delta: float) -> void:
	var x = get_global_mouse_position().x
	var y = get_global_mouse_position().y
	position.x = lerp(position.x, x, 1 - pow(0.005, delta))
	position.y = lerp(position.y, y, 1 - pow(0.005, delta))
	#position.x = x
	#position.y = y
	if position.y < -GameState.CENTER.y:
		position.y = -GameState.CENTER.y
	if position.y > GameState.CENTER.y:
		position.y = GameState.CENTER.y
	if position.x < -GameState.CENTER.x:
		position.x = -GameState.CENTER.x
	if position.x > GameState.CENTER.x:
		position.x = GameState.CENTER.x

func get_hit(damage: float):
	pass
