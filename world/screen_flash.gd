extends Sprite2D

var flash: float = 0

func flash_50():
	flash = 0.5

func _physics_process(delta: float) -> void:
	if GameState.alive == 1:
		modulate.a = flash
		flash *= 0.92
	else:
		modulate.a = 0
