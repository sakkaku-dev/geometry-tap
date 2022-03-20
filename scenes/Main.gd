extends Node2D

onready var score_label: Label = $CanvasLayer/Control/TopBar/HBoxContainer/Score
onready var geometries: Node2D = $Geometries
onready var outlines_rect: Control = $CanvasLayer/Control/MarginContainer/ColorRect
onready var outlines: Control = $CanvasLayer/Control/MarginContainer/CenterContainer/Outlines

var logger = Logger.new("Main")

func _ready():
	ScoreManager.connect("score_updated", self, "_update_score")

func _get_close_enough_geometry() -> Geometry:
#	var outlines_threshold = 200
#	var outlines_min = outlines.rect_global_position.y - outlines_threshold
#	var outlines_max = outlines.rect_global_position.y + outlines_threshold
	
	var rect = Rect2(outlines_rect.rect_global_position, outlines_rect.rect_size)
	
	for child in geometries.get_children():
		if not child.moved and rect.has_point(child.global_position):
			return child
	return null


func _get_outline_for_direction(dir: Vector2) -> Control:
	for child in outlines.get_children():
		var child_pos_dir = _center_pos(outlines).direction_to(_center_pos(child))
		var dir_unit = dir.normalized()
		if dir_unit.dot(child_pos_dir) == 1:
			return child
	return null


func _center_pos(ctrl: Control) -> Vector2:
	return ctrl.rect_global_position + ctrl.rect_size / 2


func _on_InputReader_swipe(left):
	var new_dir = Vector2.LEFT if left else Vector2.RIGHT
	logger.info("Swipe: %s" % new_dir)
	
	var geometry = _get_close_enough_geometry()
	if geometry:
		var matching_outline = _get_outline_for_direction(new_dir)
		
		if matching_outline:
			if matching_outline.name in geometry.name:
				geometry.match = true
				logger.info("Correct match")
				ScoreManager.increase_score(1)
			else:
				logger.info("Wrong match")
		else:
			logger.info("No matching outline found for %s" % new_dir)
		geometry.move(new_dir)
	else:
		logger.info("No geometry close enough")


func _update_score(score):
	score_label.text = str(score)
