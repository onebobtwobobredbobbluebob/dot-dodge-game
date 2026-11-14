extends Sprite2D

var flash: float = 0
var disabled: bool = true

func _ready() -> void:
	GameState.screen_flash = self

func flash_50():
	flash = 0.5

func _physics_process(delta: float) -> void:
	if disabled == false:
		modulate.a = flash
		flash *= 0.92
	else:
		modulate.a = 0
		flash = 0
