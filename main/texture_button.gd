extends TextureButton

var target_scale = 1

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	scale = lerp(scale, Vector2(1, 1) * target_scale, 1 - pow(0.05, delta))
	if is_hovered():
		target_scale = 1.1
	else:
		target_scale = 1
