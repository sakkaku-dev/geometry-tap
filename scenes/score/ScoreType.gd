class_name ScoreType extends Label

onready var timer := $Timer

func _ready():
	_on_Timer_timeout()

func update_score(type: int) -> void:
	var text = ""
	
	match type:
		ScoreManager.ScoreType.PERFECT: text = "Perfect"
		ScoreManager.ScoreType.GOOD: text = "Good"
		ScoreManager.ScoreType.OK: text = "OK"
	
	self.text = text
	timer.start()


func _on_Timer_timeout():
	text = ""
