extends Node2D

var ring: int
var i: int
var j: int
var x: int
var y: int

func _process(delta: float) -> void:
	modulate.v = 2.0 / (ring + 1)
	var size = 5
	$Label.text = str(j) + ", " + str(i)
	$Label2.text = str(ring)
