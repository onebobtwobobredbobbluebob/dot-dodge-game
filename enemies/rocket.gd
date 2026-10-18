extends Area2D

class_name Rocket

var acceleration: float = 4
var speed: float = 3
var mode: float = 0
var angular_vel: float = 0
var old_rotation: float = 0
var vel: Vector2 = Vector2(0, 0)

func _ready() -> void:
	position = Vector2(randf_range(-GameState.CENTER.x, GameState.CENTER.x), -GameState.CENTER.y - 80)
	var target_rotation = position.direction_to(GameState.player.position).normalized().angle()
	rotation = target_rotation

func _physics_process(delta: float) -> void:
	mode += 1
	if mode < 200:
		var target_rotation = position.direction_to(GameState.player.position).normalized().angle()
		rotation = lerp_angle(rotation, target_rotation, 0.2)
		angular_vel = rotation - old_rotation
		vel = transform.x * speed
		old_rotation = rotation
	else:
		vel = transform.x * speed * acceleration
		acceleration *= 1.02
		rotation += angular_vel
		angular_vel *= 0
	position += vel
	if abs(position.x) > (GameState.CENTER.x + 100):
		#print("dedx")
		queue_free()
	if abs(position.y) > (GameState.CENTER.y + 100):
		#print("dedy")
		queue_free()
	#print(position.y - -GameState.CENTER.y)
	if get_overlapping_bodies().has(GameState.player):
		#print("nji4hufbwejh4e")
		GameState.player.get_hit(10)
		queue_free()
