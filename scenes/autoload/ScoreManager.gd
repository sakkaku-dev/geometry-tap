extends Node

signal score_updated(score)
signal geometry_missed()

var score = 0

func increase_score(delta: int) -> void:
	score += delta
	emit_signal("score_updated", score)

func missed() -> void:
	emit_signal("geometry_missed")
