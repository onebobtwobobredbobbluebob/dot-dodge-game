extends TextureButton

class_name SkillPart

var mouse_down: bool = false
var mouse_over: bool = false
var orig_position: Vector2 = position
var old_gobal_mouse_pos: Vector2 = position
var skill: Skill = Skill.new()

func _ready() -> void:
	$Sprite2D.scale = Vector2(1, 1) * (1.154 / 150) * size / 2
	$Sprite2D.texture = skill.texture
	$Sprite2D.modulate = skill.modulate
	mouse_entered.connect(entered)
	mouse_exited.connect(exited)

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not(event.pressed == true and mouse_over == false):
			mouse_down = event.pressed
	if event is InputEventMouseMotion:
		if mouse_down:
			get_parent().position += (get_global_mouse_position() - old_gobal_mouse_pos)
		old_gobal_mouse_pos = get_global_mouse_position()

func entered():
	mouse_over = true

func exited():
	mouse_over = false
