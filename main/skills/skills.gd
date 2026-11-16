extends Node2D

var skill_opacity: float = 1

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if $GraphEdit.mouse_over:
		skill_opacity = 0.1
	else:
		skill_opacity = 1
	
	if $SkillOutside.mouse_down:
		$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
		$SkillOutside.modulate.a = skill_opacity
		$Skill.modulate.a = 1.1 - skill_opacity
