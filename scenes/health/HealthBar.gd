class_name HealthBar extends Control

signal zero_health()

export var initial_health := 3

onready var health_tex := $TextureRect
onready var health = initial_health

var logger = Logger.new("HealthBar")
var health_size: Vector2

func _ready():
	health_size = health_tex.texture.get_size()
	_update_health(0)
	
	ScoreManager.connect("geometry_missed", self, "_update_health", [-1])
	
func _update_health(delta: int):
	health += delta
	health_tex.rect_size.x = max(health_size.x * health, 0)

	logger.info("Setting health to %s" % health)

	if health <= 0:
		emit_signal("zero_health")

func reset_health():
	_update_health(initial_health - health)
