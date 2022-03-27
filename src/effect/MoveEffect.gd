class_name MoveEffect extends Effect

export var start_offset = Vector2.LEFT

func apply_tween(tween: Tween):
	for node in get_nodes():
		var property = "rect_global_position" if node is Control else "global_position" 
		var start = node.get(property) + start_offset
		var end = node.get(property)
		
		var initial_value
		var initial_modulate
		
		if reverse:
			tween.interpolate_property(node, property, end, start, duration)
			tween.interpolate_property(node, "modulate", Color.white, Color.transparent, duration)
			initial_value = end
			initial_modulate = Color.white
		else:
			tween.interpolate_property(node, property, start, end, duration)
			tween.interpolate_property(node, "modulate", Color.transparent, Color.white, duration)
			initial_value = start
			initial_modulate = Color.transparent
			
		if set_initial:
			if not node is Control:
				node.set(property, initial_value)
			node.set("modulate", initial_modulate)
