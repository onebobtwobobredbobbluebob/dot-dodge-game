extends Area2D

var mouse_over: bool = false

func _ready() -> void:
	mouse_entered.connect(entered)
	mouse_exited.connect(exited)

func entered():
	mouse_over = true

func exited():
	mouse_over = false
