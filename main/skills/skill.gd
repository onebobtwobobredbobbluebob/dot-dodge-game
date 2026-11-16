extends GraphElement

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	emit_signal("dragged")
