extends CharacterBody2D

const DEFLECT_PARTICLES = preload("uid://6m76bfy25dbd")
var speed: float = 0
var old_pos: Vector2 = position
var max_health: float = GameState.player_max_health
var health: float = max_health
var flash_timer: float = 0
var flash: float = 1
var flash_green: float = 1
var skip_to_death: bool = false
signal screen_flash

func _ready() -> void:
	GameState.player = self

func _process(delta: float) -> void:
	var lerp_time = 0.005
	if GameState.speed:
		lerp_time = 0.002
	var x = get_global_mouse_position().x
	var y = get_global_mouse_position().y
	position.x = lerp(position.x, x, 1 - pow(lerp_time, delta))
	position.y = lerp(position.y, y, 1 - pow(lerp_time, delta))
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
	
	if skip_to_death:
		get_hit(100, 3, 0)
		health = -40

func get_hit(damage: float, flash_time: float, screen_shake: float):
	if damage < 0:
		if skip_to_death:
			return
		flash_green = 0.8
		$HealParticles.emitting = true
	else:
		if(randf_range(0, 100) < GameState.chance_of_deflecting):
			flash = flash_time * 0.6
			var deflect = DEFLECT_PARTICLES.instantiate()
			add_child(deflect)
			health -= damage * 0.1
			emit_signal("screen_flash")
			GameState.camera.shake += screen_shake * 0.5

			return
	GameState.camera.shake += screen_shake
	flash = flash_time
	health -= damage
