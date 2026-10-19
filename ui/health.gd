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
		x = (GameState.player.health / GameState.player.max_health) * 233 + -236
	$Sprite2D3/Sprite2D.position.x += (x - $Sprite2D3/Sprite2D.position.x) * 0.05
