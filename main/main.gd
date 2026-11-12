extends Node2D

var timer: float = 0
var startup_timer: float = 0
var leaderboard: bool = false
var player_id: String
var board_ready: bool = false
var timer2: float = 0
var reload: bool = false
var startup: bool = true
const WORLD = preload("uid://b3ow5ef8lcb2r")
const SHOP_ITEM = preload("uid://ce27aullyq3ty")
var world = WORLD.instantiate()
var game_paused: bool = false
var main = false

var shop_items: Array[Control]


func _ready() -> void:
	CheddaBoards.set_api_key("cb_dot-dodge-2_c0f4373ea37958099d97e7823b098e6b")
	CheddaBoards.set_game_id("dot-dodge-2")
	CheddaBoards.scoreboard_loaded.connect(_on_leaderboard)
	CheddaBoards.nickname_changed.connect(changed_nick)
	
	$Ded/Button.pressed.connect(back_button_pressed)
	$Title/TextureButton.pressed.connect(start_game)
	$Title/TextureButton2.pressed.connect(start_shop)
	$Paused/EndRun.pressed.connect(end_run)
	$Paused/GoBack.pressed.connect(go_back)
	$Shop/GoBack.pressed.connect(shop_go_back)
	
	instantiate_shop()
	
	get_board_ready()
	

func instantiate_shop():
	instantiate_shop_item(0, 5, 1, 5, 5, "hp buff")
	instantiate_shop_item(0, 3, 2, 10, 5, "more heals")
	instantiate_shop_item(0, 1, 3, 40, 0, "speed buff")
	instantiate_shop_item(0, 4, 4, 25, 15, "deflect")
	
	for i in shop_items:
		$Shop/Sprite2D2/VScrollBar/VBoxContainer.add_child(i)

func instantiate_shop_item(level: int, max_level: int, icon: int, price: int, price_increase: int, item_name: String):
	var new_item = SHOP_ITEM.instantiate()
	
	new_item.level = level
	new_item.max_level = max_level
	new_item.icon = icon
	new_item.price = price
	new_item.price_increase = price_increase
	new_item.item_name = item_name
	
	new_item.broke.connect(broke_no_money)
	
	shop_items.append(new_item)


func _process(delta: float) -> void:
	$Paused.visible = false
	if startup:
		$Startup.visible = true
		startup_timer += delta * 0.5
		$Title.visible = false
		$Shop.visible = false
		if startup_timer < 1:
			$Startup/Sprite2D.modulate.a = startup_timer
		else:
			$Startup/Sprite2D.modulate.a = 1
		if startup_timer > 2:
			$Title.visible = true
			$Startup.modulate.a = 1 - (startup_timer - 2)
		if $Startup.modulate.a <= 0:
			start_main_menu()
			startup = false
	else:
		$Startup.visible = false
		if GameState.alive == 2:
			if is_instance_valid(world):
				world.queue_free()
			if leaderboard:
				in_leaderboard(delta)
			else:
				in_death_screen()
		elif GameState.alive == 1:
			in_game(delta)
		if GameState.alive == 0:
			if GameState.shop:
				in_shop()
			elif main:
				in_main_menu()


func start_main_menu():
	GameState.shop = false
	main = true
	GameState.alive = 0
	$Ded.visible = false
	$LeaderBoard.visible = false
	$Shop.visible = false
	$Title.visible = true

func in_main_menu():
	$Ded.visible = false
	$LeaderBoard.visible = false
	$Shop.visible = false
	$Title.visible = true


func start_game():
	start_main_menu()
	startup = false
	game_paused = false
	GameState.alive = 1
	timer = 0
	$Camera2D.restart()
	$Title.visible = false
	$Ded.visible = false
	$Shop.visible = false
	$LeaderBoard.visible = false
	GameState.start_game()
	world = WORLD.instantiate()
	add_child(world)
	world.get_tree().paused = false

func in_game(delta: float):
	main = false
	$Ded.visible = false
	if game_paused == false:
		if timer > 1.5:
			start_death_screen()
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
		if Input.is_action_just_pressed("pause"):
			game_paused = true
			world.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		$Paused.visible = true
		if Input.is_action_just_pressed("pause"):
			game_paused = false
			world.process_mode = Node.PROCESS_MODE_INHERIT
	#print(game_paused)

func end_run():
	world.find_child("Player").skip_to_death = true
	game_paused = false
	world.process_mode = Node.PROCESS_MODE_INHERIT

func go_back():
	if is_instance_valid(world):
		world.queue_free()
	start_main_menu()

func start_death_screen():
	GameState.total_coins += GameState.coins
	GameState.alive = 2
	$Ded/Label2.set_score(int(round(GameState.timer)))
	CheddaBoards.submit_score_to_board("high-scores", int(round(GameState.timer)))
	#print(int(round(GameState.timer)))

func in_death_screen():
	main = false
	$Ded.visible = true
	$LeaderBoard.visible = false
	if Input.is_action_just_pressed("toggle_leaderboard"):
		start_leaderboard()
	elif Input.is_action_just_pressed("escape"):
		start_main_menu()

func back_button_pressed():
	start_main_menu()

func start_leaderboard():
	leaderboard = true
	CheddaBoards.get_scoreboard("high-scores", 100)
	$LeaderBoard/Label.text = "loading..."

func in_leaderboard(delta: float):
	if board_ready:
		if CheddaBoards._nickname_just_changed:
			timer2 = 0
		if timer2 <= 8:
			timer2 -= delta
		if timer2 < 0:
			timer2 = 10
			CheddaBoards.get_scoreboard("high-scores", 100)
			$LeaderBoard/Label.text = "loading..."
		if reload:
			CheddaBoards.get_scoreboard("high-scores", 100)
			$LeaderBoard/Label.text = "loading..."
			reload = false
		if $LeaderBoard/LineEdit.submitted and not $LeaderBoard/LineEdit.submitted_string == "":
			CheddaBoards.change_nickname($LeaderBoard/LineEdit.submitted_string)
			$LeaderBoard/Label.text = "changing nickname..."
			$LeaderBoard/LineEdit.submitted = false
			#print("dwaefawef")
	$Ded.visible = false
	$LeaderBoard.visible = true
	if Input.is_action_just_pressed("toggle_leaderboard") and not $LeaderBoard/LineEdit.has_focus():
			leaderboard = false

func start_shop():
	GameState.shop = true


func in_shop():
	main = false
	$Shop.visible = true
	$Title.visible = false
	
	GameState.player_max_health = 80 + shop_items.get(0).level * 20
	GameState.heal_spawn_rate = 14 - shop_items.get(1).level * 2
	if shop_items.get(2).level == 0:
		GameState.speed = false
	else:
		GameState.speed = true
	GameState.chance_of_deflecting = shop_items.get(3).level * 10
	
	if Input.is_action_just_pressed("escape"):
		start_main_menu()
	if Input.is_action_pressed("cheat3") and Input.is_action_just_pressed("cheat") and Input.is_action_just_pressed("cheat2"):
		GameState.total_coins += 50000

func shop_go_back():
	start_main_menu()

func broke_no_money():
		$Shop/Node2D/Label3.shake += 5

func _on_leaderboard(id: String, config: Dictionary, entries: Array):
	print(id + ": " + "entires: " + str(entries.size()))
	print("playerid: " + CheddaBoards.get_player_id())
	var contains: bool = false
	if CheddaBoards.get_nickname() == "":
		contains = true
	for i in entries:
		if CheddaBoards.get_nickname() == i.nickname:
			contains = true
		else:
			print(i.nickname)
	if contains:
		$LeaderBoard/Label.text = "Global Leaderboard"
		for i in entries:
			print(i)
			$LeaderBoard/Label.text += "\n" + (str(int(round(i.rank))) + ": " + str(i.nickname) + " - " + str(int(round(i.score))))
	else:
		print("ERROR: DOES NOT CONTAIN NICKNAME, RELOADING: " + CheddaBoards.get_nickname())
		reload = true
	print(CheddaBoards.get_nickname())

func get_board_ready():
	await CheddaBoards.wait_until_ready()
	CheddaBoards.login_anonymous()
	player_id = CheddaBoards.get_player_id()
	board_ready = true
func changed_nick(s: String):
	print(s + " vs " + CheddaBoards.get_nickname())
