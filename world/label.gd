extends Label

var timer: float

func _process(delta: float) -> void:
	text = "Score: " + str(int(round(timer)))
	timer += delta
