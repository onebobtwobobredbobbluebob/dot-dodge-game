extends Camera2D

var shake: float = 0

func _ready() -> void:
	GameState.camera = self

func _physics_process(delta: float) -> void:
	if GameState.alive:
		position = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
		shake *= 0.92
		zoom += (Vector2(1, 1) - zoom) * 0.1
	else:
		position = Vector2(0, 0)
