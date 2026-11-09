extends TextureButton

@export var normal_scale = 0.5
@export var hovered_multiplier = 1.1
var target_scale = normal_scale

func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	scale = lerp(scale, Vector2(1, 1) * target_scale, 1 - pow(0.001, delta))
	if is_hovered():
		target_scale = hovered_multiplier * normal_scale
	else:
		target_scale = normal_scale
