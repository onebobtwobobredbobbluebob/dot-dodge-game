extends Node2D


func _physics_process(delta: float) -> void:
	var x: float
	if GameState.player.health < 0:
		GameState.player.health = 0
	if GameState.player.health == GameState.player.max_health:
		x = -3
	elif GameState.player.health == 0:
		x = -236
	else:
		x = (GameState.player.health / GameState.player.max_health) * 230 + -233
	$Sprite2D3/HealthInsides.position.x += (x - $Sprite2D3/HealthInsides.position.x) * 0.05
	if abs(x - $Sprite2D3/HealthInsides.position.x) < 0.6:
		$Sprite2D3/HealthFlashEffect.position.x += ($Sprite2D3/HealthInsides.position.x - $Sprite2D3/HealthFlashEffect.position.x) * 0.1
