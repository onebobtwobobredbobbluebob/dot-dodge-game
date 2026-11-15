extends Node2D

const SKILLS_TREE_NOTCH = preload("uid://iwgkjkwx0lcf")

func _ready() -> void:
	var size = 5
	var dist = 150
	var y_dist = sqrt(dist * dist * 4 / 5.0)
	print(y_dist)
	for i in size * 2 + 1:
		for j in (size * 2 + 1) - abs(i - size):
			var notch = SKILLS_TREE_NOTCH.instantiate()
			notch.position = Vector2((j - size) * dist + abs(size - i) * dist / 2.0, (i - size) * y_dist)
			notch.ring = round(abs(j - (((float(size) * 2.0) - abs(i - size)) / 2)) + (abs(i - size)))
			#abs(i - size)
			notch.i = i
			notch.j = j
			add_child(notch)

func _process(delta: float) -> void:
	pass
