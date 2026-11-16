extends Node2D

var skill_opacity: float = 1
var old_mouse_down: bool = false
var old_inside_mouse_down: bool = false
var old_mouse_over: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if $GraphEdit.mouse_over:
		skill_opacity = 0
	else:
		skill_opacity = 1
	
	if $SkillOutside.mouse_down or $GraphEdit/Skill.mouse_down:
		$GraphEdit/Skill.visible = true
		if $SkillOutside.mouse_down:
			$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom) - ($GraphEdit/Skill.size / 2)
		$SkillOutside.modulate.a = skill_opacity
		$GraphEdit/Skill.modulate.a = 1 - skill_opacity
		if $GraphEdit.mouse_over:
			var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
			$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos).nearest = true
	
	if old_mouse_down and not $SkillOutside.mouse_down:
		var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
		var nearest: Notch =  $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
		if nearest.enabled:
			$GraphEdit/Skill.position_offset = (nearest.position - $GraphEdit/Skill.size / 2) + $GraphEdit/GraphElement.position_offset
		else:
			$SkillOutside.position = $SkillOutside.orig_position
			skill_opacity = 1
			$GraphEdit/Skill.visible = true
			$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
			$SkillOutside.modulate.a = skill_opacity
			$GraphEdit/Skill.modulate.a = 1 - skill_opacity
	
	if old_mouse_over and not $SkillOutside.mouse_over:
		$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(Vector2(0, 0))
	
	if $GraphEdit/Skill.mouse_down:
		#$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom) - ($GraphEdit/Skill.size / 2)
		#$GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
		#($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - ($SkillOutside.size / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset = $SkillOutside.position
		$SkillOutside.position = ($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - ($SkillOutside.size / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset
	
	if old_inside_mouse_down and not $GraphEdit/Skill.mouse_down:
		if $GraphEdit.mouse_over:
			var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
			var nearest: Notch =  $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
			if nearest.enabled:
				$GraphEdit/Skill.position_offset = (nearest.position - $GraphEdit/Skill.size / 2) + $GraphEdit/GraphElement.position_offset
			else:
				$SkillOutside.position = $SkillOutside.orig_position
				skill_opacity = 1
				$GraphEdit/Skill.visible = true
				$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
				$SkillOutside.modulate.a = skill_opacity
				$GraphEdit/Skill.modulate.a = 1 - skill_opacity
		else:
			$SkillOutside.position = $SkillOutside.orig_position
			skill_opacity = 1
			$GraphEdit/Skill.visible = true
			$GraphEdit/Skill.position_offset = ($SkillOutside.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillOutside.size / 2 / $GraphEdit.zoom)
			$SkillOutside.modulate.a = skill_opacity
			$GraphEdit/Skill.modulate.a = 1 - skill_opacity
			
	
	old_mouse_down = $SkillOutside.mouse_down
	old_inside_mouse_down = $GraphEdit/Skill.mouse_down
	old_mouse_over = $SkillOutside.mouse_over
