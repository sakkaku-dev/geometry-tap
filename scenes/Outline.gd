class_name Outline extends Sprite

onready var particles := $Particles2D

func _ready():
	particles.texture = texture

func emit(color: Color):
	particles.emitting = true
	particles.modulate = color
