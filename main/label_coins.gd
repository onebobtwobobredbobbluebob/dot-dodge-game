extends Label

var shake = 0

func _process(delta: float) -> void:
	text = "coins: " + str(GameState.total_coins)

func _physics_process(delta: float) -> void:
	position = Vector2(randf_range(-shake, shake), randf_range(-shake, shake))
	shake *= 0.92
	#print(shake)
