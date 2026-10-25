extends Sprite2D

var timer: float
var target_a: float = 0

func _ready() -> void:
	scale = Vector2(1.2, 1.2)

func _process(delta: float) -> void:
	if timer > 360:
		timer = fmod(timer, 360)
	timer += delta
	scale = Vector2(1.2, 1.2) * (1 + (sin(timer * 4) * 0.04))
	
	if GameState.player.health < (GameState.player.max_health / 3):
		target_a = 1.0 + (-GameState.player.health / (GameState.player.max_health / 3))
	else:
		target_a = 0
	modulate.a = lerp(modulate.a, target_a, 1 - pow(0.2, delta))
	
	if not GameState.alive:
		visible = false
