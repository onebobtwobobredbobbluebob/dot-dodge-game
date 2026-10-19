extends Camera2D

var shake: float = 0

func _ready() -> void:
	GameState.camera = self

func _physics_process(delta: float) -> void:
	position = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	shake *= 0.92
