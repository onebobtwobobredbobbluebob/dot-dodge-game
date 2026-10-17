extends CharacterBody2D


func _process(delta: float) -> void:
	var target_rotation = position.direction_to(GameState.player.position).normalized().angle()
	lerp(rotation, target_rotation, 1 - pow(0.005, delta))
	rotation = lerp_angle(rotation, target_rotation, 1 - pow(0.005, delta))
	position += transform.x
