extends TextureButton

var mouse_down: bool = false
var mouse_over: bool = false

func _ready() -> void:
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
			position += event.screen_relative

func entered():
	mouse_over = true

func exited():
	mouse_over = false
