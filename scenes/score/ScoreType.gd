class_name ScoreType extends Label

onready var timer := $Timer
onready var tween := $Tween

func _ready():
	hide()
	rect_pivot_offset = rect_size / 2

func update_score(type: int) -> void:
	self.self_modulate = _glow_color(ScoreManager.get_color(type))
	self.text = ScoreManager.get_text(type)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Play")

func _glow_color(color: Color) -> Color:
	var amount = 0.5
	color.r += amount
	color.g += amount
	color.b += amount
	return color
