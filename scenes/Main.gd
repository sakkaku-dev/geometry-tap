extends Node2D

onready var geometries := $Geometries
onready var outlines_rect: Control = $CanvasLayer/Control/MarginContainer/ColorRect

var logger = Logger.new("Main")

func get_current_geometry() -> Geometry:
#	var outlines_threshold = 200
#	var outlines_min = outlines.rect_global_position.y - outlines_threshold
#	var outlines_max = outlines.rect_global_position.y + outlines_threshold
	
	var rect = Rect2(outlines_rect.rect_global_position, outlines_rect.rect_size)
	
	for child in geometries.get_children():
		if not child.moved and rect.has_point(child.global_position):
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
