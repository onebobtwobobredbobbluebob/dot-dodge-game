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
			notch.ring = 1
			var x = floor(j - (((float(size) * 2.0) - abs(i - size)) / 2))
			var y = (abs(i - size))
			notch.x = x
			notch.y = y
			var current_pos: Vector2 = Vector2((j - size) * dist + abs(size - i) * dist / 2.0, (i - size) * y_dist)
			var counter: int = 0
			
			while(current_pos.distance_to(Vector2(0, 0)) > 30):
				var new_pos = current_pos
				var temp_pos = new_pos
				var current_dist = temp_pos.distance_to(Vector2(0, 0))
				var new_dist: float
				var min_dist: float = current_dist
				for o in 6:
					temp_pos = current_pos + Vector2.from_angle(deg_to_rad(60 * o)) * dist
					new_dist = temp_pos.distance_to(Vector2(0, 0))
					if(new_dist < min_dist):
						min_dist = new_dist
						new_pos = temp_pos
				current_pos = new_pos
				print(str(current_pos) + " - " + str(counter))
				print(current_pos.distance_to(Vector2(0, 0)) < 50)
				counter += 1
			notch.ring = counter
			add_child(notch)
			
			

func _process(delta: float) -> void:
	pass
