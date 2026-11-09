extends Node2D

var level: int = 0
var max_level: int = 0
var icon: int = 1
var price: int = 0
var price_increase: int = 0
var item_name: String = "item123"

signal broke

func _ready() -> void:
	$TextureButton.pressed.connect(buy)
	pass

func _process(delta: float) -> void:
	if max_level > level:
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer/HBoxContainer/Price.text = price
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = true
		$TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = false
		$TextureButton.animation_disabled = false
	else:
		$TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = true
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = false
		$TextureButton.animation_disabled = true
	
	$CenterContainer/VBoxContainer/Name.text = item_name
	$CenterContainer/VBoxContainer/CenterContainer/Count.text = str(level) + "/" + str(max_level)
	$Icon.texture = load("res://assets/shop/icons/" + str(icon) + ".png")
	if max_level <= level or GameState.total_coin < price:
		modulate.v = 0.8
	else:
		modulate.v = 1
	

func buy():
	if max_level > level:
		if GameState.total_coin < price:
			emit_signal("broke")
		else:
			GameState.total_coin -= price
			level += 1
			price += price_increase
			
	else:
		$TextureButton.shake += 10
		
