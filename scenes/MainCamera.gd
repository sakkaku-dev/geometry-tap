class_name MainCamera extends Camera2D

onready var default_offset = offset
onready var shake_timer := $Timer

var shake_amount = 5.0
var screen_shake = false

func _process(delta):
	if screen_shake:
		var shake_offset = Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount
		)
		
		set_offset(default_offset + shake_offset)

func shake():
	screen_shake = true
	shake_timer.start()


func _on_Timer_timeout():
	screen_shake = false
