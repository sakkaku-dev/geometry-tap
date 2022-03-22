class_name ScoreType extends Label

onready var timer := $Timer

const SCORE_DATA = {
	ScoreManager.ScoreType.PERFECT: {"text": "Perfect", "color": Color.red},
	ScoreManager.ScoreType.GOOD: {"text": "Good", "color": Color.green},
	ScoreManager.ScoreType.OK: {"text": "OK", "color": Color.yellow},
}

func _ready():
	_on_Timer_timeout()

func update_score(type: int) -> void:
	var score_data = SCORE_DATA[type]
	if score_data:
		self.modulate = _glow_color(score_data.color)
		self.text = score_data.text
		timer.start()

func _glow_color(color: Color) -> Color:
	var amount = 0.3
	color.r += amount
	color.g += amount
	color.b += amount
	return color

func _on_Timer_timeout():
	text = ""
