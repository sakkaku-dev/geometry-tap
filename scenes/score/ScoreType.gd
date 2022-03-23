class_name ScoreType extends Label

onready var timer := $Timer


func _ready():
	_on_Timer_timeout()

func update_score(type: int) -> void:
	self.modulate = _glow_color(ScoreManager.get_color(type))
	self.text = ScoreManager.get_text(type)
	timer.start()

func _glow_color(color: Color) -> Color:
	var amount = 0.3
	color.r += amount
	color.g += amount
	color.b += amount
	return color

func _on_Timer_timeout():
	text = ""
