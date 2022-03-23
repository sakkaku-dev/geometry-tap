class_name GeometrySpawner extends Node2D

export var parent_path: NodePath
onready var parent: Node2D = get_node(parent_path)

export var geometries: Array
export var initial_speed = 500
export var initial_spawn_time = 1.0

export var delay_min = 1
export var delay_max = 3

onready var spawn_timer: Timer = $SpawnTimer
onready var delay_timer: Timer = $DelayTimer

var speed = 0
var new_speed = 0
var spawn_time = 1
var subsequent_spawned_total = 0
var random = RandomNumberGenerator.new()

var logger = Logger.new("GeometrySpawner")

func _ready():
	ScoreManager.connect("score_updated", self, "_on_score_updated")


func _on_score_updated(score: int) -> void:
	new_speed = min(2000, initial_speed + max(1, score / 10.0))
	spawn_time = max(1 / (speed / (initial_speed * 1.0)), 0.5)
	logger.debug("Setting new speed and time: %s / %ss" % [new_speed, spawn_time])


func start_timer() -> void:
	subsequent_spawned_total = 0
	speed = initial_speed
	new_speed = speed
	spawn_time = initial_spawn_time
	spawn_timer.start(spawn_time)


func _on_DelayTimer_timeout():
	speed = new_speed
	spawn_timer.start(spawn_time)
	logger.debug("Spawning in %s seconds" % spawn_time)


func _on_SpawnTimer_timeout():
	var geometry = _random_geometry().instance()
	geometry.speed = speed
	parent.add_child(geometry)
	geometry.global_position = global_position
	subsequent_spawned_total += 1

	var delay_chance = 0.1 * (subsequent_spawned_total / 3.0)
	if randf() <= delay_chance:
		var delay = random.randf_range(delay_min, delay_max)
		logger.debug("Delaying spawn for %s seconds" % delay)
		delay_timer.start(delay)
		subsequent_spawned_total = 0
	else:
		_on_DelayTimer_timeout()


func _random_geometry() -> PackedScene:
	var random_idx = randi() % geometries.size()
	return geometries[random_idx]
