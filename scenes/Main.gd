extends Node2D

var logger = Logger.new("Main")

func _on_InputReader_swipe(left):
	logger.info("Swipe: %s" % ("left" if left else "right"))
