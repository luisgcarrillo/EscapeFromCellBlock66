extends Camera2D

var threshold = 10
var step = 4
@onready var viewport_size = get_viewport().size
@onready var player = $"../Player"
@export var x_scroll = 0.0
@export var y_scroll = 0.0
@onready var camera_2d = $"."
var original_position = global_position


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.player_died.connect(camera_reset)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	camera_2d.position.x += x_scroll * delta
	camera_2d.position.y += y_scroll * delta


func camera_reset():
	camera_2d.position = original_position
