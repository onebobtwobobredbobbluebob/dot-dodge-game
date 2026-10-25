extends Node2D

var timer: float = 0
var leaderboard: bool = false

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
		$World.visible = false
		
		if leaderboard:
			if $Ded.visible or CheddaBoards.nickname_changed:
				CheddaBoards.get_leaderboard("score", 100)
				$LeaderBoard/Label.text = "loading..."
			if $LeaderBoard/LineEdit.text_submitted:
				CheddaBoards.change_nickname($LeaderBoard/LineEdit.text)
			$Ded.visible = false
			$LeaderBoard.visible = true
			if Input.is_action_just_pressed("toggle_leaderboard"):
				leaderboard = false
			
		else:
			$Ded.visible = true
			$LeaderBoard.visible = false
			
			if Input.is_action_just_pressed("toggle_leaderboard"):
				leaderboard = true
	else:
		$Ded.visible = false
		if timer > 1.5:
			GameState.alive = false
			$Ded/Label2.set_score(int(round(GameState.timer)))
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
	$LeaderBoard/Label.text = "Global Leaderboard"
	for i in entries:
		$LeaderBoard/Label.text += "\n" + (str(int(i.rank)) + ": " + str(i.nickname) + " - " + str(int(i.score)))
