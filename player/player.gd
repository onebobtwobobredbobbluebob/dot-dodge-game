extends CharacterBody2D

var speed: float = 0
var old_pos: Vector2 = position

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
	speed = (old_pos - position).length()
	if speed > 40:
		speed = 40
	old_pos = position
func get_hit(damage: float):
	pass
