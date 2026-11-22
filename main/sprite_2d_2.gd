extends Sprite2D


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	$Bg1.position = get_global_mouse_position() * 0.005
	$Bg2.position = get_global_mouse_position() * 0.01
	$Bg3.position = get_global_mouse_position() * 0.02
	$Bg4.position = get_global_mouse_position() * 0.04
	$Bg5.position = get_global_mouse_position() * 0.06
	$Bg6.position = get_global_mouse_position() * 0.01
