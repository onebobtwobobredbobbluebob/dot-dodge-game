extends GraphElement

class_name SkillNodeInside

const SKILL_INSIDE = preload("uid://cveeubbyrapkn")
var mouse_down: bool = false
var mouse_over: bool = false
var old_gobal_mouse_pos: Vector2 = Vector2(0, 0)
var zoom: float = 1
var skill: Skill = Skill.new()
var parts: Array[SkillInsidePart]

func _ready() -> void:
	for i in skill.layout:
		
		var skill_part = SKILL_INSIDE.instantiate()
		skill_part.position = get_pos(i)
		skill_part.skill = skill
		parts.append(skill_part)
		add_child(skill_part)

func get_pos(coords: Vector3) -> Vector2:
	var vector = Vector2(0, 0)
	for i in coords.x:
		vector.x += GameState.skill_dist
	for i in coords.y:
		vector.x += GameState.skill_dist * cos(PI / 3)
		vector.y += GameState.skill_dist * sin(PI / 3)
	for i in coords.z:
		vector.x += GameState.skill_dist * cos(2 * PI / 3)
		vector.y += GameState.skill_dist * sin(2 * PI / 3)
	return vector

func _process(delta: float) -> void:
	mouse_over = false
	mouse_down = false
	for i in parts:
		if i.mouse_over:
			mouse_over = true
		if i.mouse_down:
			mouse_down = true
		i.zoom = zoom
