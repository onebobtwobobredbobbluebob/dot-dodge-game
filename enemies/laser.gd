extends Area2D

class_name Laser
var timer: float
var damage_cooldown: float = 0
var flash: float = 0

func _ready() -> void:
	position.x = randf_range(-GameState.CENTER.x * 0.3, GameState.CENTER.x * 0.3)
	position.y = randf_range(-GameState.CENTER.y * 0.3, GameState.CENTER.y * 0.3)
	rotation_degrees = randf_range(0, 360)

func _physics_process(delta: float) -> void:
	if abs(position.x) > (GameState.CENTER.x + 100):
		#print("dedx")
		queue_free()
	if abs(position.y) > (GameState.CENTER.y + 100):
		#print("dedy")
		queue_free()
	
	if timer < 2:
		$Sprite2D.frame = 2
		modulate.a = 0.5
	elif timer < 5:
		$Sprite2D.frame = 0
		modulate.a = 1
		if get_overlapping_bodies().has(GameState.player):
			if damage_cooldown < 0:
				GameState.player.get_hit(2, 0.7)
				if GameState.camera.shake < 30:
					GameState.camera.shake += 3
				damage_cooldown = 0.07
				flash = 0.3
		damage_cooldown -= delta
	else:
		$Sprite2D.frame = 1
		modulate.a -= delta
		if modulate.a <= 0:
			queue_free()
	flash = lerp(flash, 0.0, 1 - pow(0.000005, delta))
	$Sprite2D/WhiteOverlay.modulate.a = flash
	timer += delta
