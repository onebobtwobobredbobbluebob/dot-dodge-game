extends Node2D

var skill_opacity: float = 1
var old_mouse_down: bool = false
var old_mouse_over: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if $GraphEdit.mouse_over:
		skill_opacity = 0.1
	else:
		skill_opacity = 1
	
	if $SkillOutside.mouse_down:
		$GraphEdit/Skill.visible = true
		$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
		$SkillOutside.modulate.a = skill_opacity
		$GraphEdit/Skill.modulate.a = 1.1 - skill_opacity
		if $GraphEdit.mouse_over:
			var pos: Vector2 = $GraphEdit/Skill.position_offset - $GraphEdit/GraphElement.position_offset
			$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos).nearest = true
	if old_mouse_down and not $SkillOutside.mouse_down:
		var pos: Vector2 = $GraphEdit/Skill.position_offset - $GraphEdit/GraphElement.position_offset
		$GraphEdit/Skill.position_offset = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos).position + $GraphEdit/GraphElement.position_offset
	if old_mouse_over and not $SkillOutside.mouse_over:
		$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(Vector2(0, 0))
	old_mouse_down = $SkillOutside.mouse_down
	old_mouse_over = $SkillOutside.mouse_over
