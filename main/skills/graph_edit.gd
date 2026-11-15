extends GraphEdit

var mouse_down: bool = false

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		print("hi")
		scroll_offset += event.relative
	print(event)
