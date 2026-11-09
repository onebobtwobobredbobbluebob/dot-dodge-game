extends Node2D

var level: int = 0
var max_level: int = 0
var icon: int = 0
var price: int = 0
var initial_price: int = 0
var price_increase: int = 0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if max_level > level:
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer/HBoxContainer/Price.text = price
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = true
		$TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = false
	else:
		$TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = true
		$TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = false
