extends Area2D

class_name SkillInsidePart

var mouse_down: bool = false
var mouse_over: bool = false
var old_gobal_mouse_pos: Vector2 = Vector2(0, 0)
var zoom: float = 1
var skill: Skill = Skill.new()

func _ready() -> void:
	mouse_entered.connect(entered)
	mouse_exited.connect(exited)

func _process(delta: float) -> void:
	$Sprite2D.modulate = skill.modulate
	$Sprite2D.texture = skill.texture

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not(event.pressed == true and mouse_over == false):
			mouse_down = event.pressed
	if event is InputEventMouseMotion:
		if mouse_down:
			get_parent().position_offset += (get_global_mouse_position() - old_gobal_mouse_pos) / zoom
		old_gobal_mouse_pos = get_global_mouse_position()
func entered():
	mouse_over = true

func exited():
	mouse_over = false
