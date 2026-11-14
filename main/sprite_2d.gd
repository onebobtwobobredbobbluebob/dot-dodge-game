extends Sprite2D

var orig_scale: Vector2 = scale
var timer: float = 0

func _process(delta: float) -> void:
	timer += delta
	scale = orig_scale + orig_scale * (sin(timer * 4) * 0.02)
