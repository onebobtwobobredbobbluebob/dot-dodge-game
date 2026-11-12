extends Node2D

var orig_position: Vector2 = position
var shake: float = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position = orig_position + Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	shake *= 0.92
