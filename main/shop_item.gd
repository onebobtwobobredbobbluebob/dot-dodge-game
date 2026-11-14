extends Control

const UPGRADE_PARTICLES = preload("uid://dsu3wu4bowljm")
var level: int = 0
var max_level: int = 0
var icon: int = 1
var price: int = 0
var price_increase: int = 0
var item_name: String = "item123"
var flash: float = 0

signal broke
signal click_particles

func _ready() -> void:
	$Node2D/TextureButton.pressed.connect(buy)
	$Node2D/TextureButton2.pressed.connect(click)

func _process(delta: float) -> void:
	if max_level > level:
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer/HBoxContainer/Price.text = str(price)
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = true
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = false
		$Node2D/TextureButton.animation_disabled = false
	else:
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.visible = true
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.visible = false
		$Node2D/TextureButton.animation_disabled = true
	
	$Node2D/CenterContainer/VBoxContainer/Name.text = item_name
	$Node2D/CenterContainer/VBoxContainer/CenterContainer/Count.text = str(level) + "/" + str(max_level)
	$Node2D/Icon.texture = load("res://assets/shop/icons/" + str(icon) + ".png")
	if max_level <= level or GameState.total_coins < price:
		modulate.v = 0.5
		$Node2D/TextureButton.animation_disabled = true
	else:
		modulate.v = 1
		$Node2D/TextureButton.animation_disabled = false
	
	flash = lerp(flash, 0.0, 1 - pow(0.000005, delta))
	$Node2D/Sprite2D5/WhiteOverlay.modulate.a = flash

func buy():
	emit_signal("click_particles")
	if max_level > level:
		if GameState.total_coins < price:
			emit_signal("broke")
			$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/CenterContainer.shake += 5
			$Node2D.shake += 2
		else:
			GameState.total_coins -= price
			level += 1
			price += price_increase
			var particles = UPGRADE_PARTICLES.instantiate()
			$Node2D.add_child(particles)
			if level == max_level:
				$Node2D.shake += 40
				GameState.camera.shake += 12
				flash = 3
				GameState.screen_flash.flash = 0.2
			else:
				$Node2D.shake += 20
				GameState.camera.shake += 5
				flash = 0.8
			
	else:
		$Node2D/TextureButton/Sprite2D/Sprite2D2/Node2D/SoldOut.shake += 7
		$Node2D/CenterContainer/VBoxContainer/CenterContainer/Count/Control/Count2.shake += 7
		$Node2D.shake += 2

func click():
	emit_signal("click_particles")
	$Node2D.shake += 3
