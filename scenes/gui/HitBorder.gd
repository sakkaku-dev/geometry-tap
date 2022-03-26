class_name HitBorder extends TextureRect


func _ready():
	hide()

func hit():
	$AnimationPlayer.play("Hit")
