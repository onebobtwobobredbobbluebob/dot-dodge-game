extends Camera2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_pressed("zoom_in"):
		scale += Vector2(1, 1) * 0.1
		print(scale)
	if Input.is_action_pressed("zoom_out"):
		print("out")
		scale -= Vector2(1, 1) * 0.1
	
