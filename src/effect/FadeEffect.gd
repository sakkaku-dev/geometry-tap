class_name FadeEffect extends Effect

func _ready():
	interpolate_all("modulate", Color.transparent)
