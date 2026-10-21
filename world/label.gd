extends Label

var score: int = 0
var old_score: int = 0
var target_scale: float = 1

func _process(delta: float) -> void:
	score = int(round(GameState.timer))
	text = "Score: " + str(score)
	if not old_score == score:
		target_scale = 1.1
	else:
		target_scale = 1
	scale = lerp(scale, Vector2(target_scale, target_scale), 1 - pow(0.0000005, delta))
	old_score = score
