class_name Effect extends Node

export var delay = 0.0
export var duration = 0.5
export var reverse = false
export var set_initial = true

export(Array, NodePath) var node_paths: Array

onready var tween: Tween = _get_tween(self)

var transition = Tween.TRANS_LINEAR
var ease_type = Tween.EASE_IN_OUT

func _get_tween(node: Node):
	var parent = node.get_parent()
	if parent is Tween:
		return parent
	if parent:
		return _get_tween(parent)

func get_nodes() -> Array:
	var result = []
	for node_path in node_paths:
		result.append(get_node(node_path))
	return result

func interpolate_all(property, start_value):
	for node in get_nodes():
		var start = node.get(start_value) if start_value is String else start_value
		var end = node.get(property)
		var initial
		
		if reverse:
			tween.interpolate_property(node, property, end, start, duration, transition, ease_type, delay)
			initial = end
		else:
			tween.interpolate_property(node, property, start, end, duration, transition, ease_type, delay)
			initial = start
		
		if set_initial:
			node.set(property, initial)
