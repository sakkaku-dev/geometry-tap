extends Control

export var next_screen: PackedScene

onready var enter := $Enter
onready var exit := $Exit

func _ready():
	enter.start()


func _on_Enter_tween_all_completed():
	exit.start()


func _on_Exit_tween_all_completed():
	get_tree().change_scene_to(next_screen)
