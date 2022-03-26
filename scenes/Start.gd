extends Control

export var main_scene: PackedScene

onready var move_in: Tween = $MoveIn
onready var move_out: Tween = $MoveOut

func _ready():
	move_in.start()

func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		move_out.start()


func _on_MoveOut_tween_all_completed():
	get_tree().change_scene_to(main_scene)
