extends Node2D

class_name Notch
var ring: int
var i: int
var j: int
var x: int
var y: int
var enabled: bool = false

func _process(delta: float) -> void:
	enabled = ring <= GameState.rings_unlocked
	if enabled:
		modulate.v = 1
		modulate.a = 1
	else:
		modulate.v = 0.1 + 0.2 / (ring - GameState.rings_unlocked)
		modulate.a = 0.5 / (ring - GameState.rings_unlocked) - 0.15
	var size = 5
	$Label.text = str(j) + ", " + str(i)
	$Label2.text = str(ring)
