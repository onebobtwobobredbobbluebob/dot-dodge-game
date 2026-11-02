extends CPUParticles2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	var x = get_global_mouse_position().x
	var y = get_global_mouse_position().y
	position = Vector2(x, y)
	pass
