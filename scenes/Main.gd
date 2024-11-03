extends Node2D

onready var score_label: Label = $CanvasLayer/Control/TopBar/HBoxContainer/VBoxContainer/Score
onready var score_type_label: ScoreType = $CanvasLayer/Control/CenterContainer/ScoreType

onready var geometries: Node2D = $Geometries
onready var spawner: GeometrySpawner = $GeometrySpawner
onready var health_bar: HealthBar = $CanvasLayer/Control/TopBar/HBoxContainer/HealthBar
onready var hit_border: HitBorder = $CanvasLayer/Control/HitBorder

onready var camera: MainCamera = $Camera2D
onready var outlines: Node2D = $GeometrySpawner/Outlines
onready var outline_scores: Node2D = $GeometrySpawner/Outlines/OutlineScores

onready var game_over: Control = $CanvasLayer/Control/GameOver
onready var show_outlines: Tween = $ShowOutlines

var logger = Logger.new("Main")

func _ready():
	show_outlines.start()
	_start_game()
	ScoreManager.connect("score_updated", self, "_update_score")
	ScoreManager.connect("geometry_missed", self, "_on_geometry_missed")


func _start_game():
	game_over.hide()
	for child in geometries.get_children():
		child.matched = true
		geometries.remove_child(child)
	spawner.start_timer()
	health_bar.reset_health()
	ScoreManager.reset_score()
	get_tree().paused = false


func _get_close_enough_geometry() -> GeometryShape:
	var outlines_threshold = 200
#	var outlines_min = outlines.rect_global_position.y - outlines_threshold
	var outlines_max = outlines.global_position.y + outlines_threshold
	
#	var rect = Rect2(outlines_rect.rect_global_position, outlines_rect.rect_size)
	
	for child in geometries.get_children():
		if not child.moved and child.global_position.y < outlines_max:
			return child
	return null


func _get_outline_for_direction(dir: Vector2) -> Outline:
	for child in outlines.get_children():
		var child_pos_dir = outlines.global_position.direction_to(child.global_position)
		var dir_unit = dir.normalized()
		if dir_unit.dot(child_pos_dir) == 1:
			return child
	return null


func _get_outline_score_for(geometry) -> OutlineScore:
	# Assuming smaller outlines are the first children
	for child in outline_scores.get_children():
		var rect = Rect2(child.rect_global_position, child.rect_size)
		if rect.has_point(geometry.global_position):
			return child
	
	return null

func _on_InputReader_swipe(left):
	var new_dir = Vector2.LEFT if left else Vector2.RIGHT
	logger.debug("Swipe: %s" % new_dir)
	
	var geometry = _get_close_enough_geometry()
	if geometry:
		var matching_outline = _get_outline_for_direction(new_dir)
		
		if matching_outline:
			if matching_outline.name in geometry.name:
				var closest_outline_score = _get_outline_score_for(geometry)
				if closest_outline_score:
					geometry.matched = true
					var score_type = closest_outline_score.score
					logger.debug("Correct match: %s" % score_type)
					ScoreManager.increase_score(score_type)
					score_type_label.update_score(score_type)
					matching_outline.emit(ScoreManager.get_color(score_type))
				else:
					logger.debug("Outline matched but did not score")
			else:
				logger.debug("Wrong match")
		else:
			logger.debug("No matching outline found for %s" % new_dir)
		geometry.move(new_dir)
	else:
		logger.debug("No geometry close enough")


func _update_score(score):
	score_label.text = str(score)


func _on_geometry_missed():
	camera.shake()
	hit_border.hit()


func _on_HealthBar_zero_health():
	game_over.show()
	get_tree().paused = true


func _on_GameOver_play_again():
	logger.info("Restart game")
	_start_game()
