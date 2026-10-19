extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true

func _process(delta: float) -> void:
	if not $CPUParticles2D.emitting:
		queue_free()
