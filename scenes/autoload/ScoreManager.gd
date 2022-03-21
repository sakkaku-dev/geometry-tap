extends Node

signal score_updated(score)
signal geometry_missed()

enum ScoreType {
	PERFECT,
	GOOD,
	OK,
}

var score = 0

func reset_score() -> void:
	score = 0
	emit_signal("score_updated", score)

func increase_score(type: int = ScoreType.OK) -> void:
	var score_amount = 1
	if type == ScoreType.GOOD:
		score_amount *= 3
	if type == ScoreType.PERFECT:
		score_amount *= 5
	
	score += score_amount
	emit_signal("score_updated", score)

func missed() -> void:
	emit_signal("geometry_missed")
