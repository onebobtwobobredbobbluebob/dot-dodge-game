extends GraphEdit

var mouse_down: bool = false
var mouse_over: bool = false

func _ready() -> void:
	mouse_entered.connect(entered)
	mouse_exited.connect(exited)

func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not(event.pressed == true and (mouse_over == false or $Skill.mouse_over == true)):
			mouse_down = event.pressed
	if event is InputEventMouseMotion:
		if mouse_down:
			scroll_offset += -event.screen_relative

func entered():
	mouse_over = true

func exited():
	mouse_over = false
