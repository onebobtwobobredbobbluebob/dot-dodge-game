extends Node2D

func _ready() -> void:
	$Layer1.emitting = true
	$Layer2.emitting = true
	$Layer3.emitting = true

func _process(delta: float) -> void:
	if not ($Layer1.emitting or $Layer2.emitting or $Layer3.emitting):
		queue_free()
