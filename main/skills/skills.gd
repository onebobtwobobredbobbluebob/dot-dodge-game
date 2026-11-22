extends Node2D

var skill_opacity: float = 1
var old_mouse_down: bool = false
var old_inside_mouse_down: bool = false
var old_mouse_over: bool = false
@export var skills: Array[Skill]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if $GraphEdit.mouse_over:
		$GraphEdit/GraphElement/SkillsTree.turn_off_notches = false
		skill_opacity = 0
	else:
		$GraphEdit/GraphElement/SkillsTree.turn_off_notches = true
		skill_opacity = 1
	
	if $SkillNode.mouse_down or $GraphEdit/Skill.mouse_down:
		$GraphEdit/Skill.visible = true
		if $SkillNode.mouse_down:
			var rel_zoom = $GraphEdit.zoom / $SkillNode.scale.x
			var mouse_offset: Vector2 = ((get_global_mouse_position() - $SkillNode.global_position) / rel_zoom - ((get_global_mouse_position() - $SkillNode.global_position)))
			$Sprite2D.position = $SkillNode.position + ($SkillNode.size / 2) + mouse_offset / $SkillNode.scale
			$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2) + mouse_offset / $SkillNode.scale - ($GraphEdit/Skill.size / 2)
		$SkillNode.modulate.a = skill_opacity
		$GraphEdit/Skill.modulate.a = 1 - skill_opacity
		if $GraphEdit.mouse_over:
			var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
			$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
			$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos).nearest = true
			for i in $GraphEdit/Skill.parts:
				var pos2: Vector2 = (($GraphEdit/Skill.position_offset + i.position) + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
				$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2).nearest = true
	
	if old_mouse_down and not $SkillNode.mouse_down:
		var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
		$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
		var nearest: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
		var nearests: Array[Notch]
		var all_enabled: bool = true
		for i in $GraphEdit/Skill.parts:
			var pos2: Vector2 = (($GraphEdit/Skill.position_offset + i.position) + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
			var nearest2: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2)
			nearests.append(nearest2)
			if not nearest2.enabled:
				all_enabled = false
		if nearest.enabled and all_enabled:
			$GraphEdit/Skill.position_offset = (nearest.position - $GraphEdit/Skill.size / 2) + $GraphEdit/GraphElement.position_offset
		else:
			$SkillNode.position = $SkillNode.orig_position
			skill_opacity = 1
			$GraphEdit/Skill.visible = true
			var rel_zoom = $GraphEdit.zoom / $SkillNode.scale.x
			var mouse_offset: Vector2 = ((get_global_mouse_position() - $SkillNode.global_position) / rel_zoom - ((get_global_mouse_position() - $SkillNode.global_position)))
			$Sprite2D.position = $SkillNode.position + ($SkillNode.size / 2) + mouse_offset / $SkillNode.scale
			$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2) + mouse_offset / $SkillNode.scale - ($GraphEdit/Skill.size / 2)
			$SkillNode.modulate.a = skill_opacity
			$GraphEdit/Skill.modulate.a = 1 - skill_opacity
	
	if old_mouse_over and not $SkillNode.mouse_over:
		$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
	
	if $GraphEdit/Skill.mouse_down:
		#$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2 / $GraphEdit.zoom) - ($GraphEdit/Skill.size / 2)
		#$GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2 / $GraphEdit.zoom)
		#($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - ($SkillNode.size / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset = $SkillNode.position
		var rel_zoom = $GraphEdit.zoom / $SkillNode.scale.x
		#var mouse_offset: Vector2 = ((get_global_mouse_position() - $GraphEdit/Skill.global_position) / rel_zoom - ((get_global_mouse_position() - $GraphEdit/Skill.global_position)))
		var mouse_offset: Vector2 = ((get_global_mouse_position() - $GraphEdit/Skill.global_position) / rel_zoom - ((get_global_mouse_position() - $GraphEdit/Skill.global_position)))
		#$SkillNode.position = ($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - mouse_offset / $SkillNode.scale - ($SkillNode.size / 2)) * $GraphEdit.zoom - $GraphEdit.scroll_offset
		#$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2) + mouse_offset / $SkillNode.scale - ($GraphEdit/Skill.size / 2)
		$Sprite2D.scale = $SkillNode.scale
		print(mouse_offset)
		$Sprite2D.position = ($GraphEdit/Skill.position_offset - ($SkillNode.size / 2) - mouse_offset / $GraphEdit.zoom + ($SkillNode.size / 2)) * $GraphEdit.zoom - $GraphEdit.scroll_offset - ($SkillNode.size * $SkillNode.scale / 2)
		$SkillNode.position = ($GraphEdit/Skill.position_offset - ($SkillNode.size / 2) - mouse_offset / $SkillNode.scale + ($GraphEdit/Skill.size / 2)) * $GraphEdit.zoom - $GraphEdit.scroll_offset
		
		#$SkillNode.position = ($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - ($SkillNode.size * $SkillNode.scale / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset - mouse_offset / $SkillNode.scale
		#var zoom_relative = $GraphEdit.zoom / $SkillNode.scale.x
		#var mouse_offset: Vector2 = ((get_global_mouse_position() - $GraphEdit/Skill.global_position) / zoom_relative - ((get_global_mouse_position() - $GraphEdit/Skill.global_position)))
		#$SkillNode.position = ($GraphEdit/Skill.position_offset + ($GraphEdit/Skill.size / 2) - ($SkillNode.size * $SkillNode.scale / 2 / zoom_relative)) * zoom_relative - $GraphEdit.scroll_offset - mouse_offset
	
	if old_inside_mouse_down and not $GraphEdit/Skill.mouse_down:
		if $GraphEdit.mouse_over:
			var pos: Vector2 = ($GraphEdit/Skill.position_offset + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
			$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
			var nearest: Notch =  $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
			var nearests: Array[Notch]
			var all_enabled: bool = true
			for i in $GraphEdit/Skill.parts:
				var pos2: Vector2 = (($GraphEdit/Skill.position_offset + i.position) + $GraphEdit/Skill.size / 2) - $GraphEdit/GraphElement.position_offset
				var nearest2: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2)
				nearests.append(nearest2)
				if not nearest2.enabled:
					all_enabled = false
			if nearest.enabled and all_enabled:
				$GraphEdit/Skill.position_offset = (nearest.position - $GraphEdit/Skill.size / 2) + $GraphEdit/GraphElement.position_offset
			else:
				$SkillNode.position = $SkillNode.orig_position
				skill_opacity = 1
				$GraphEdit/Skill.visible = true
				$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2 / $GraphEdit.zoom)
				$SkillNode.modulate.a = skill_opacity
				$GraphEdit/Skill.modulate.a = 1 - skill_opacity
		else:
			$SkillNode.position = $SkillNode.orig_position
			skill_opacity = 1
			$GraphEdit/Skill.visible = true
			$GraphEdit/Skill.position_offset = ($SkillNode.position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + ($SkillNode.size / 2 / $GraphEdit.zoom)
			$SkillNode.modulate.a = skill_opacity
			$GraphEdit/Skill.modulate.a = 1 - skill_opacity
			
	
	old_mouse_down = $SkillNode.mouse_down
	old_inside_mouse_down = $GraphEdit/Skill.mouse_down
	old_mouse_over = $SkillNode.mouse_over
