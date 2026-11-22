extends GraphEdit

var mouse_down: bool = false
var mouse_over: bool = false

func _ready() -> void:
	mouse_entered.connect(entered)
	mouse_exited.connect(exited)

func _process(delta: float) -> void:
	var children: Array[Node] = get_children()
	for i in children:
		if i is SkillNodeInside:
			i.zoom = zoom

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_over_any: bool = false
		var children: Array[Node] = get_children()
		for i in children:
			if i is SkillNodeInside:
				if i.mouse_over == true:
					mouse_over_any = true
		if not(event.pressed == true and (mouse_over == false or mouse_over_any == true)):
			mouse_down = event.pressed
	if event is InputEventMouseMotion:
		if mouse_down:
			scroll_offset += -event.screen_relative

func entered():
	mouse_over = true

func exited():
	mouse_over = false
