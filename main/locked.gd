extends Sprite2D

var is_visible: bool = true

func _process(delta: float) -> void:
	if is_visible == false:
		modulate.a = lerp(modulate.a, 0.0, 1 - pow(0.000001, delta))
	else:
		modulate.a = 1
	
	visible = modulate.a > 0.0001
