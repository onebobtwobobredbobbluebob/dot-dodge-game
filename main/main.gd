extends Node2D

var timer: float = 0

func _ready() -> void:
	GameState.alive = true

func _process(delta: float) -> void:
	if GameState.alive == false:
		$World.visible = false
	else:
		if timer > 1.5:
			GameState.alive = false
			$Label2.set_score(int(round($World/Label.timer)))
		if GameState.player.health <= 0:
			timer += delta
			GameState.camera.shake = 50
		else:
			timer = 0
	print(timer)
		
