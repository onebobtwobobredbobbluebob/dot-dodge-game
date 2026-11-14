extends Node2D

func _ready() -> void:
	$CPUParticles2D.emitting = true

func _process(delta: float) -> void:
	position.y -= 1000 * delta
	if not $CPUParticles2D.emitting:
		queue_free()
