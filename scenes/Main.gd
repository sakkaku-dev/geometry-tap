extends Node2D

onready var geometries := $Geometries
onready var outlines := $Outlines

var logger = Logger.new("Main")

func get_current_geometry() -> Geometry:
	var outlines_threshold = 200
	
	for child in geometries.get_children():
		var outlines_min = outlines.global_position.y - outlines_threshold
		var outlines_max = outlines.global_position.y + outlines_threshold
		var child_y = child.global_position.y
		
		if not child.moved and child_y > outlines_min and child_y < outlines_max:
			return child
	return null

func _on_InputReader_swipe(left):
	var new_dir = Vector2.LEFT if left else Vector2.RIGHT
	logger.info("Swipe: %s" % new_dir)
	
	var geometry = get_current_geometry()
	if geometry:
		geometry.move(new_dir)
	else:
		logger.info("No geometry close enough")
