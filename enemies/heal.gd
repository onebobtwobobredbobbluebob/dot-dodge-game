extends Area2D

class_name Health
const EXPLOSION = preload("uid://brk38ev5nd2cg")
var mode: bool = randf_range(0, 2) > 1
var speed: float = 3
var angular_vel: float = 3
var damage_cooldown: float = 0
var flash: float = 0
func _ready() -> void:
	position = Vector2(randf_range(-GameState.CENTER.x * 0.9, GameState.CENTER.x * 0.9), randf_range(-GameState.CENTER.y * 0.9, GameState.CENTER.y * 0.9))

func _physics_process(delta: float) -> void:
	if abs(position.x) > (GameState.CENTER.x + 100):
		#print("dedx")
		queue_free()
	if abs(position.y) > (GameState.CENTER.y + 100):
		#print("dedy")
		queue_free()
	
	if get_overlapping_bodies().has(GameState.player):
		#print("nji4hufbwejh4e")
		if damage_cooldown < 0:
			GameState.player.get_hit(-1, 0.7)
			#delete()
			GameState.camera.shake += 3
			damage_cooldown = 0.1
			flash = 0.3
	damage_cooldown -= delta
	rotation_degrees += angular_vel
	
	flash = lerp(flash, 0.0, 1 - pow(0.000005, delta))
	$Sprite2D/Sprite2D.modulate.a = flash

func delete():
	var explosion = EXPLOSION.instantiate()
	explosion.position = position
	explosion.position += transform.x * 30
	GameState.camera.shake += 30
	#GameState.camera.zoom = Vector2(0.9, 0.9)
	add_sibling(explosion)
	queue_free()
