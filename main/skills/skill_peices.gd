extends Resource

class_name Skill
@export var layout: Array[Vector3] = [Vector3(0, 0, 0)]
@export var name: String = "new skill thing aa"
@export var scale: float = 1
@export var position: Vector2 = Vector2(546.0, -181.0)
@export var texture: Texture2D = load("res://assets/costume2.svg")
@export var modulate: Color = Color(1.0, 1.0, 1.0, 1.0)
var activated: bool = false
