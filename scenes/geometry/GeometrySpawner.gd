class_name GeometrySpawner extends Node2D

export var geometries: Array

export var parent_path: NodePath
onready var parent: Node2D = get_node(parent_path)

onready var timer: Timer = $Timer

var logger = Logger.new("GeometrySpawner")

func _random_geometry() -> PackedScene:
	var random_idx = randi() % geometries.size()
	return geometries[random_idx]


func _on_Timer_timeout():
	var geometry = _random_geometry().instance()
	parent.add_child(geometry)
	geometry.global_position = global_position


func start_timer(start_time: float) -> void:
	timer.wait_time = start_time
	timer.start()
