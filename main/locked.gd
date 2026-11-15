extends Sprite2D

var is_visible

func _process(delta: float) -> void:
	if is_visible == false:
		modulate.a = lerp(modulate.a, 0, 1 - pow(0.0001, delta))
	else:
		modulate.a = 1
