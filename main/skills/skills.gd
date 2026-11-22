extends Node2D


const SKILL = preload("uid://bq61ka5k8c26d")
const SKILL_NODE = preload("uid://dt8h3y138sf7s")

var skill_opacities: Array[float]
var old_mouse_downs: Array[bool]
var old_inside_mouse_downs: Array[bool]
var old_mouse_overs: Array[bool]
@export var skills: Array[Skill]
var skill_outsides: Array[SkillNodeOutside]
var skill_insides: Array[SkillNodeInside]

func _ready() -> void:
	for i in skills:
		var skill_inside = SKILL.instantiate()
		skill_inside.skill = i
		skill_insides.append(skill_inside)
		$GraphEdit.add_child(skill_inside)
		
		var skill_outside = SKILL_NODE.instantiate()
		skill_outside.skill = i
		skill_outsides.append(skill_outside)
		$SkillNodeOutsides.add_child(skill_outside)
		
		skill_opacities.append(1)
		old_mouse_downs.append(false)
		old_inside_mouse_downs.append(false)
		old_mouse_overs.append(false)

func _process(delta: float) -> void:
	for s in skills:
		if $GraphEdit.mouse_over:
			$GraphEdit/GraphElement/SkillsTree.turn_off_notches = false
			skill_opacities[s] = 0
		else:
			$GraphEdit/GraphElement/SkillsTree.turn_off_notches = true
			skill_opacities[s] = 1
		
		if skill_outsides[s].mouse_down or skill_insides[s].mouse_down:
			skill_insides[s].visible = true
			if skill_outsides[s].mouse_down:
				var rel_zoom = $GraphEdit.zoom / skill_outsides[s].scale.x
				var mouse_offset: Vector2 = ((get_global_mouse_position() - skill_outsides[s].global_position) / rel_zoom - ((get_global_mouse_position() - skill_outsides[s].global_position)))
				$Sprite2D.position = skill_outsides[s].position + (skill_outsides[s].size / 2) + mouse_offset / skill_outsides[s].scale
				skill_insides[s].position_offset = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2) + mouse_offset / skill_outsides[s].scale - (skill_insides[s].size / 2)
			skill_outsides[s].modulate.a = skill_opacities[s]
			skill_insides[s].modulate.a = 1 - skill_opacities[s]
			if $GraphEdit.mouse_over:
				var pos: Vector2 = (skill_insides[s].position_offset + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
				$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
				$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos).nearest = true
				for i in skill_insides[s].parts:
					var pos2: Vector2 = ((skill_insides[s].position_offset + i.position) + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
					$GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2).nearest = true
		
		if old_mouse_downs[s] and not skill_outsides[s].mouse_down:
			var pos: Vector2 = (skill_insides[s].position_offset + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
			$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
			var nearest: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
			var nearests: Array[Notch]
			var all_enabled: bool = true
			for i in skill_insides[s].parts:
				var pos2: Vector2 = ((skill_insides[s].position_offset + i.position) + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
				var nearest2: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2)
				nearests.append(nearest2)
				if not nearest2.enabled:
					all_enabled = false
			if nearest.enabled and all_enabled:
				skill_insides[s].position_offset = (nearest.position - skill_insides[s].size / 2) + $GraphEdit/GraphElement.position_offset
			else:
				skill_outsides[s].position = skill_outsides[s].orig_position
				skill_opacities[s] = 1
				skill_insides[s].visible = true
				var rel_zoom = $GraphEdit.zoom / skill_outsides[s].scale.x
				var mouse_offset: Vector2 = ((get_global_mouse_position() - skill_outsides[s].global_position) / rel_zoom - ((get_global_mouse_position() - skill_outsides[s].global_position)))
				$Sprite2D.position = skill_outsides[s].position + (skill_outsides[s].size / 2) + mouse_offset / skill_outsides[s].scale
				skill_insides[s].position_offset = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2) + mouse_offset / skill_outsides[s].scale - (skill_insides[s].size / 2)
				skill_outsides[s].modulate.a = skill_opacities[s]
				skill_insides[s].modulate.a = 1 - skill_opacities[s]
		
		if old_mouse_overs[s] and not skill_outsides[s].mouse_over:
			$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
		
		if skill_insides[s].mouse_down:
			#skill_insides[s].position_offset = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2 / $GraphEdit.zoom) - (skill_insides[s].size / 2)
			#skill_insides[s].position_offset + (skill_insides[s].size / 2) = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2 / $GraphEdit.zoom)
			#(skill_insides[s].position_offset + (skill_insides[s].size / 2) - (skill_outsides[s].size / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset = skill_outsides[s].position
			var rel_zoom = $GraphEdit.zoom / skill_outsides[s].scale.x
			var mouse_offset: Vector2 = ((get_global_mouse_position() - skill_insides[s].global_position) / rel_zoom - ((get_global_mouse_position() - skill_insides[s].global_position)))

			$Sprite2D.scale = skill_outsides[s].scale
			skill_outsides[s].position = (skill_insides[s].position_offset - (skill_outsides[s].size / 2) - mouse_offset / $GraphEdit.zoom + (skill_outsides[s].size / 2)) * $GraphEdit.zoom - $GraphEdit.scroll_offset - (skill_outsides[s].size * skill_outsides[s].scale / 2)
			
			#skill_outsides[s].position = (skill_insides[s].position_offset + (skill_insides[s].size / 2) - (skill_outsides[s].size * skill_outsides[s].scale / 2 / $GraphEdit.zoom)) * $GraphEdit.zoom - $GraphEdit.scroll_offset - mouse_offset / skill_outsides[s].scale
			#var zoom_relative = $GraphEdit.zoom / skill_outsides[s].scale.x
			#var mouse_offset: Vector2 = ((get_global_mouse_position() - skill_insides[s].global_position) / zoom_relative - ((get_global_mouse_position() - skill_insides[s].global_position)))
			#skill_outsides[s].position = (skill_insides[s].position_offset + (skill_insides[s].size / 2) - (skill_outsides[s].size * skill_outsides[s].scale / 2 / zoom_relative)) * zoom_relative - $GraphEdit.scroll_offset - mouse_offset
			
		if old_inside_mouse_downs[s] and not skill_insides[s].mouse_down:
			if $GraphEdit.mouse_over:
				var pos: Vector2 = (skill_insides[s].position_offset + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
				$GraphEdit/GraphElement/SkillsTree.clear_nearest_notch()
				var nearest: Notch =  $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos)
				var nearests: Array[Notch]
				var all_enabled: bool = true
				for i in skill_insides[s].parts:
					var pos2: Vector2 = ((skill_insides[s].position_offset + i.position) + skill_insides[s].size / 2) - $GraphEdit/GraphElement.position_offset
					var nearest2: Notch = $GraphEdit/GraphElement/SkillsTree.get_nearest_notch(pos2)
					nearests.append(nearest2)
					if not nearest2.enabled:
						all_enabled = false
				if nearest.enabled and all_enabled:
					skill_insides[s].position_offset = (nearest.position - skill_insides[s].size / 2) + $GraphEdit/GraphElement.position_offset
				else:
					skill_outsides[s].position = skill_outsides[s].orig_position
					skill_opacities[s] = 1
					skill_insides[s].visible = true
					skill_insides[s].position_offset = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2 / $GraphEdit.zoom)
					skill_outsides[s].modulate.a = skill_opacities[s]
					skill_insides[s].modulate.a = 1 - skill_opacities[s]
			else:
				skill_outsides[s].position = skill_outsides[s].orig_position
				skill_opacities[s] = 1
				skill_insides[s].visible = true
				skill_insides[s].position_offset = (skill_outsides[s].position + $GraphEdit.scroll_offset) / $GraphEdit.zoom + (skill_outsides[s].size / 2 / $GraphEdit.zoom)
				skill_outsides[s].modulate.a = skill_opacities[s]
				skill_insides[s].modulate.a = 1 - skill_opacities[s]
				
		
		old_mouse_downs[s] = skill_outsides[s].mouse_down
		old_inside_mouse_downs[s] = skill_insides[s].mouse_down
		old_mouse_overs[s] = skill_outsides[s].mouse_over
