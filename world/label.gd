extends Label

func _process(delta: float) -> void:
	text = "Score: " + str(int(round(GameState.timer)))
