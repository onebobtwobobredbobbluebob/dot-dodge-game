extends Node2D

var ring: int
var i: int
var j: int

func _process(delta: float) -> void:
	modulate.v = 2.0 / (ring + 1)
	var size = 5
	$Label.text = str(j) + ", " + str(i)
	var x = floor(abs(j - (((float(size) * 2.0) - abs(i - size)) / 2)))
	var y = (abs(i - size))
	$Label2.text = x
