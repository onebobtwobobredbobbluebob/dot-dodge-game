extends GraphEdit

func _process(delta: float) -> void:
	print("hi")
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
		scroll_offset += event.relative
	print("hi")
	
