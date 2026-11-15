extends Node2D

const SKILLS_TREE_NOTCH = preload("uid://iwgkjkwx0lcf")

func _ready() -> void:
	var size = 5
	var dist = 150
	var y_dist = sqrt(2 * dist * dist)
	for i in size * 2 + 1:
		for j in (size * 2 + 1) - abs(i - y_dist):
			var notch = SKILLS_TREE_NOTCH.instantiate()
			notch.position = Vector2((j - size) * dist + abs(size - i) * dist / 2.0, (i - size) * y_dist)
			add_child(notch)

func _process(delta: float) -> void:
	pass
