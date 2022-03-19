extends KinematicBody2D

export var speed = 300

var logger = Logger.new("Geometry")

func _physics_process(delta: float):
	var velocity = Vector2.DOWN * speed
	move_and_slide(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	logger.info("Remove geometry: %s" % name)
	queue_free()
