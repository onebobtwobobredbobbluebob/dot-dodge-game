extends CharacterBody2D

var speed: float = 0
var old_pos: Vector2 = position
var max_health: float = 100
var health: float = 100
var flash_timer: float = 0
var flash: float = 1
var flash_green: float = 1

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
	
	flash = lerp(flash, 0.0, 1 - pow(0.0005, delta))
	$Sprite2D/WhiteOverlay.modulate.a = flash
	
	flash_green = lerp(flash_green, 0.0, 1 - pow(0.05, delta))
	$Sprite2D/GreenOverlay.modulate.a = flash_green
	
	if health > max_health:
		health = max_health

func get_hit(damage: float, flash_time: float):
	flash = flash_time
	health -= damage
	if damage < 0:
		flash_green = 0.8
		$HealParticles.emitting = true
