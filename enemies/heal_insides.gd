extends Sprite2D

var x: float = 0

func _ready() -> void:
	position.x = x - 70

func _process(delta: float) -> void:
	x += delta * 120
	if x > 140:
		x = fmod(x, 140)
	
	position.x = x - 70
