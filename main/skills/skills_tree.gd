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
			var new_i: int = i
			var new_j: int = j
			var counter: int = 0
			while(Vector2(new_j, new_i) != Vector2(size, size)):
				var temp_i: int = new_i
				var temp_j: int = new_j
				var current_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				var new_dist: float
				var min_dist: float = current_dist
				
				temp_j = new_j - 1
				temp_i = new_i - 1
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				
				temp_j = new_j
				temp_i = new_i - 1
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				temp_j = new_j + 1
				temp_i = new_i
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				temp_j = new_j
				temp_i = new_i + 1
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				temp_j = new_j - 1
				temp_i = new_i + 1
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				temp_j = new_j - 1
				temp_i = new_i
				
				new_dist = Vector2((temp_j - size) * dist + abs(size - temp_i) * dist / 2.0, (temp_i - size) * y_dist).length()
				if(new_dist < min_dist):
					min_dist = new_dist
					new_j = j
					new_i = i
				
				
				
				x = floor(abs(temp_j - (((float(size) * 2.0) - abs(temp_i - size)) / 2)))
				y = (abs(temp_i - size))
			
			add_child(notch)
			
			

func _process(delta: float) -> void:
	pass
