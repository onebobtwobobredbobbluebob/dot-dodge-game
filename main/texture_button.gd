extends TextureButton

@export var normal_scale: float = 0.5
@export var hovered_multiplier: float = 1.1
var target_scale: float = normal_scale
var animation_disabled: bool = false
var shake: float = 0
var initial_position: Vector2 = position

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if animation_disabled:
		scale = Vector2(1, 1) * normal_scale
		target_scale = normal_scale
	else:
		scale = lerp(scale, Vector2(1, 1) * target_scale, 1 - pow(0.001, delta))
		if is_hovered():
			target_scale = hovered_multiplier * normal_scale
		else:
			target_scale = normal_scale
	position = initial_position + Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	shake *= 0.92
