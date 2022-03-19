class_name Geometry extends KinematicBody2D

export var speed = 500

var moved = false
var direction = Vector2.DOWN
var logger = Logger.new("Geometry")

func move(dir: Vector2):
	direction = dir
	moved = true
	speed = 2000

func _physics_process(delta: float):
	var velocity = direction * speed
	move_and_slide(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	logger.info("Remove geometry: %s" % name)
	queue_free()
