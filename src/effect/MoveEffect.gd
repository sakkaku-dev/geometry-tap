class_name MoveEffect extends Node

export var start_offset = Vector2.LEFT
export var duration = 0.5
export var reverse = false

export(Array, NodePath) var node_paths: Array

onready var tween: Tween = get_parent()

func _ready():
	for node_path in node_paths:
		var node = get_node(node_path)
		var property = "rect_global_position" if node is Control else "global_position" 
		var start = node.get(property) + start_offset
		var end = node.get(property)
		
		var initial_value
		var initial_modulate
		
		if reverse:
			tween.interpolate_property(node, property, end, start, duration)
			tween.interpolate_property(node, "modulate", node.modulate, Color.transparent, duration)
			initial_value = end
			initial_modulate = node.modulate
		else:
			tween.interpolate_property(node, property, start, end, duration)
			tween.interpolate_property(node, "modulate", Color.transparent, node.modulate, duration)
			initial_value = start
			initial_modulate = Color.transparent
			
		if not node is Control:
			node.set(property, initial_value)
			node.set("modulate", initial_modulate)
