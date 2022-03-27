extends Tween

var call_count = 0

func _ready():
	_apply()
	
func start():
	if call_count > 0:
		_apply()
	call_count += 1
	.start()

func _apply():
	for child in get_children():
		if child is Effect:
			child.apply_tween(self)
