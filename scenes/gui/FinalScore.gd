class_name FinalScore extends Label

export(ScoreManager.ScoreType) var score_type: int

func show():
	self.self_modulate = ScoreManager.get_color(score_type)
	self.text = "%s: %s" % [ScoreManager.get_text(score_type), ScoreManager.scores_count[score_type]]
