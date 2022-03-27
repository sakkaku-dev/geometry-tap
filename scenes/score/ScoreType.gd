class_name ScoreType extends Control

onready var score_type_label := $ScoreType
onready var combo_label := $Combo

func _ready():
	hide()
	rect_pivot_offset = rect_size / 2
	
	ScoreManager.connect("combo_updated", self, "_update_combo")

func update_score(type: int) -> void:
	score_type_label.self_modulate = _glow_color(ScoreManager.get_color(type))
	score_type_label.text = ScoreManager.get_text(type)
	$AnimationPlayer.stop()
	$AnimationPlayer.play("Play")

func _glow_color(color: Color) -> Color:
	var amount = 0.5
	color.r += amount
	color.g += amount
	color.b += amount
	return color


func _update_combo(combo):
	combo_label.text = str(combo) + "x"
