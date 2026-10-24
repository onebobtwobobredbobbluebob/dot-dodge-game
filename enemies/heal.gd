extends Area2D

class_name Health
const EXPLOSION = preload("uid://brk38ev5nd2cg")
var mode: int = randi_range(1, 4)
var speed: float = 3
var angular_vel: float = 3
var damage_cooldown: float = 0
var flash: float = 0
var target_position: Vector2
func _ready() -> void:
	target_position = Vector2(randf_range(-GameState.CENTER.x * 0.9, GameState.CENTER.x * 0.9), randf_range(-GameState.CENTER.y * 0.9, GameState.CENTER.y * 0.9))
	while (target_position - GameState.player.position).length() < 300:
		target_position = Vector2(randf_range(-GameState.CENTER.x * 0.9, GameState.CENTER.x * 0.9), randf_range(-GameState.CENTER.y * 0.9, GameState.CENTER.y * 0.9))
	
	if mode == 1:
		position = Vector2(GameState.CENTER.x + 80, randf_range(-GameState.CENTER.y, GameState.CENTER.y))
	elif mode == 2:
		position = Vector2(-(GameState.CENTER.x + 80), randf_range(-GameState.CENTER.y, GameState.CENTER.y))
	elif mode == 3:
		position = Vector2(randf_range(-GameState.CENTER.x, GameState.CENTER.x), GameState.CENTER.y + 80)
	else:
		position = Vector2(randf_range(-GameState.CENTER.x, GameState.CENTER.x), -(GameState.CENTER.y + 80))

func _physics_process(delta: float) -> void:
	position = lerp(position, target_position, 1 - pow(0.00005, delta))
	position = lerp(position, target_position, 1 - pow(0.00005, delta))
	if abs(position.x) > (GameState.CENTER.x + 100):
		#print("dedx")
		queue_free()
	if abs(position.y) > (GameState.CENTER.y + 100):
		#print("dedy")
		queue_free()
	
	if get_overlapping_bodies().has(GameState.player):
		#print("nji4hufbwejh4e")
		GameState.player.get_hit(-10, 0.7)
		delete()
		#GameState.camera.shake += 3
		#damage_cooldown = 0.1
		#flash = 0.3
	#damage_cooldown -= delta
	#rotation_degrees += angular_vel
	
	flash = lerp(flash, 0.0, 1 - pow(0.000005, delta))
	$Sprite2D/Sprite2D.modulate.a = flash

func delete():
	var explosion = EXPLOSION.instantiate()
	explosion.position = position
	explosion.position += transform.x * 30
	#GameState.camera.shake += 30
	#GameState.camera.zoom = Vector2(0.9, 0.9)
	add_sibling(explosion)
	queue_free()
