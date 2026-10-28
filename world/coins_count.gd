extends Label

var coins: int = 0
var old_coins: int = 0
var target_scale: float = 1

func _process(delta: float) -> void:
	coins = int(round(GameState.coins))
	text = "Coins: " + str(coins)
	if not old_coins == coins:
		target_scale = 1.1
	else:
		target_scale = 1
	scale = lerp(scale, Vector2(target_scale, target_scale), 1 - pow(0.0000005, delta))
	old_coins = coins
