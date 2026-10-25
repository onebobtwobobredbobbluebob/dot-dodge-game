extends Node2D

var timer: float = 0
var leaderboard: bool = false
var player_id: String
var board_ready: bool = false

func _ready() -> void:
	CheddaBoards.set_api_key("cb_dot-dodge-2_c0f4373ea37958099d97e7823b098e6b")
	CheddaBoards.set_game_id("dot-dodge-2")
	CheddaBoards.scoreboard_loaded.connect(_on_leaderboard)
	get_board_ready()
	GameState.alive = true

func _process(delta: float) -> void:
	if GameState.alive == false:
		$World.visible = false
		
		if leaderboard:
			if board_ready:
				if $Ded.visible or CheddaBoards._nickname_just_changed:
					CheddaBoards.get_scoreboard("high-scores", 100)
					$LeaderBoard/Label.text = "loading..."
				if $LeaderBoard/LineEdit.submitted and not $LeaderBoard/LineEdit.submitted_string == "":
					CheddaBoards.change_nickname(player_id)
					$LeaderBoard/Label.text = "changing nickname..."
					$LeaderBoard/LineEdit.submitted = false
					#print("dwaefawef")
			$Ded.visible = false
			$LeaderBoard.visible = true
			if Input.is_action_just_pressed("toggle_leaderboard") and not $LeaderBoard/LineEdit.has_focus():
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
			CheddaBoards.submit_score_to_board("high-scores", int(round(GameState.timer)))
			#print(int(round(GameState.timer)))
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
		
func _on_leaderboard(id: String, config: Dictionary, entries: Array):
	$LeaderBoard/Label.text = "Global Leaderboard"
	print(id + ": " + "entires: " + str(entries.size()))
	print("playerid: " + CheddaBoards.get_player_id())
	for i in entries:
		print(i)
		$LeaderBoard/Label.text += "\n" + (str(int(round(i.rank))) + ": " + str(i.nickname) + " - " + str(int(round(i.score))))
func get_board_ready():
	await CheddaBoards.wait_until_ready()
	CheddaBoards.login_anonymous()
	player_id = CheddaBoards.get_player_id()
	board_ready = true
