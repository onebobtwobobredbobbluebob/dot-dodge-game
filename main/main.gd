extends Node2D

var timer: float = 0

func _ready() -> void:
	CheddaBoards.set_api_key("cb_dot-dodge_7d2a118c7376213e8ee98b5ed9e2f688")
	CheddaBoards.set_game_id("dot-dodge")
	CheddaBoards.leaderboard_loaded.connect(_on_leaderboard)
	await CheddaBoards.wait_until_ready()
	CheddaBoards.login_anonymous()
	GameState.alive = true

func _process(delta: float) -> void:
	if GameState.alive == false:
		if $World.visible:
			CheddaBoards.submit_score(int(round(GameState.timer)))
			print("leaderboard")
			CheddaBoards.get_leaderboard("score", 100)
		$World.visible = false
	else:
		if timer > 1.5:
			GameState.alive = false
			$Label2.set_score(int(round(GameState.timer)))
		if GameState.player.health <= 0:
			timer += delta
			GameState.camera.shake += delta * 5
			if GameState.camera.shake < 50:
				GameState.camera.shake = 50
		else:
			timer = 0
			if GameState.camera.shake > 60:
				#print(GameState.camera.shake)
				GameState.camera.shake = 60
		
func _on_leaderboard(entries: Array):
	for i in entries:
		print(str(i.rank) + ": " + str(i.nickname) + " - " + str(i.score))
