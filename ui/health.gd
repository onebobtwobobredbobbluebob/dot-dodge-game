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

	$Sprite2D3/HealthHealEffect.position.x += (x - $Sprite2D3/HealthHealEffect.position.x) * 0.05
	if $Sprite2D3/HealthInsides.position.x > x:
		$Sprite2D3/HealthInsides.position.x += (x - $Sprite2D3/HealthInsides.position.x) * 0.05
	else:
		if abs(x - $Sprite2D3/HealthHealEffect.position.x) < 7:
			$Sprite2D3/HealthInsides.position.x += ($Sprite2D3/HealthHealEffect.position.x - $Sprite2D3/HealthInsides.position.x) * 0.1
	if abs(x - $Sprite2D3/HealthInsides.position.x) < 0.8:
		$Sprite2D3/HealthFlashEffect.position.x += ($Sprite2D3/HealthInsides.position.x - $Sprite2D3/HealthFlashEffect.position.x) * 0.1
	if x - $Sprite2D3/HealthInsides.position.x > 7:
		$HealParticles.emitting = true
	if GameState.player.health > 0:
		GameState.player.health += (GameState.player.max_health / 100) * delta
