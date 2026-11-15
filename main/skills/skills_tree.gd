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
			notch.i = i
			notch.j = j
			
			var counter = 0
			var puedo_pos: Vector2 = notch.position
			while(puedo_pos != Vector2(0, 0)):
				puedo_pos.angle_to(Vector2(0, 0))
				counter += 1
				
			
			add_child(notch)
			
			

func _process(delta: float) -> void:
	pass
