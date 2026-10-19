extends Area2D

class_name Saw
const EXPLOSION = preload("uid://brk38ev5nd2cg")
var mode: bool = randf_range(0, 2) > 1
var speed: float = 3
var angular_vel: float = 0
func _ready() -> void:
	if mode:
		position = Vector2(GameState.CENTER.x + 80, randf_range(-GameState.CENTER.y, GameState.CENTER.y))
	else:
		position = Vector2(-(GameState.CENTER.x + 80), randf_range(-GameState.CENTER.y, GameState.CENTER.y))

func _physics_process(delta: float) -> void:
	var actual_speed = speed * (1 + (GameState.timer / 40))
	if actual_speed > 15:
		actual_speed = 15
	if mode:
		position.x -= speed 
	else:
		position.x += speed
	
	if get_overlapping_bodies().has(GameState.player):
		#print("nji4hufbwejh4e")
		GameState.player.get_hit(10)
		var explosion = EXPLOSION.instantiate()
		explosion.position = position
		explosion.position += transform.x * 30
		GameState.camera.shake += 30
		#GameState.camera.zoom = Vector2(0.9, 0.9)
		add_sibling(explosion)
		queue_free()
