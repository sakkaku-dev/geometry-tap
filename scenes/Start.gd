extends Control

export var main_scene: PackedScene

onready var move_in: Tween = $MoveIn
onready var move_out: Tween = $MoveOut
onready var high_score_label: Label = $CenterContainer/VBoxContainer/HighScore

func _ready():
	move_in.start()
	
	var high_score = ScoreManager.get_highscore()
	if high_score:
		high_score_label.show()
		high_score_label.text = "High Score\n" + str(high_score)
	else:
		high_score_label.hide()
	

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		move_out.start()


func _on_MoveOut_tween_all_completed():
	get_tree().change_scene_to(main_scene)
