extends Node

signal combo_updated(combo)
signal score_updated(score)
signal geometry_missed()

enum ScoreType {
	PERFECT,
	GOOD,
	OK,
}

var score = 0
var combo = 0

func reset_score() -> void:
	score = 0
	combo = 0
	emit_signal("score_updated", score)
	emit_signal("combo_updated", combo)

func increase_score(type: int = ScoreType.OK) -> void:
	var score_amount = 1
	if type == ScoreType.GOOD:
		score_amount *= 3
	if type == ScoreType.PERFECT:
		score_amount *= 5
	
	combo += 1
	score += score_amount * combo
	emit_signal("score_updated", score)
	emit_signal("combo_updated", combo)


func missed() -> void:
	combo = 0
	emit_signal("geometry_missed")
	emit_signal("combo_updated", combo)
