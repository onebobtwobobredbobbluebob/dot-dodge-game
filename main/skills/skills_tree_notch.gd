extends Node2D

class_name Notch
var ring: int
var i: int
var j: int
var x: int
var y: int
var nearest: bool = false
var enabled: bool = false

func _process(delta: float) -> void:
	enabled = ring <= GameState.rings_unlocked
	modulate = Color(1, 1, 1)
	if enabled:
		modulate.v = 1
		modulate.a = 1
	else:
		modulate.v = 0.1 + 0.2 / (ring - GameState.rings_unlocked)
		modulate.a = 0.5 / (ring - GameState.rings_unlocked) - 0.15
	
	if nearest:
		if not enabled:
			scale = Vector2(1, 1) * 0.96
			modulate = Color(2.603, 0.079, 0.079, modulate.a + 0.2)
		else:
			scale = Vector2(1, 1) * 0.9
			modulate = Color(1.2, 1.2, 1.2, modulate.a)
	else:
		scale = Vector2(1, 1)
	$Label.text = str(j) + ", " + str(i)
	$Label2.text = str(ring)
