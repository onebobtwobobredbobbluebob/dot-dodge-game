extends CharacterBody2D

class_name Rocket

var acceleration: float = 4
var speed: float = 3
var mode: float = 0
var angular_vel: float = 0
var old_rotation: float = 0


func _physics_process(delta: float) -> void:
	mode += 1
	if mode < 200:
		var target_rotation = position.direction_to(GameState.player.position).normalized().angle()
		rotation = lerp_angle(rotation, target_rotation, 0.2)
		angular_vel = rotation - old_rotation
		velocity = transform.x * speed
		old_rotation = rotation
	else:
		velocity = transform.x * speed * acceleration
		acceleration *= 1.02
		rotation += angular_vel
		angular_vel *= 0
	position += velocity
	print(mode)
