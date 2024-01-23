extends Area2D
 
var can_open = false
@onready var door = $"."
@onready var collision_shape_2d = $CollisionShape2D
@onready var door_closed = $DoorClosed
@onready var door_open = $DoorOpen
@onready var Key = get_tree().get_nodes_in_group("Key")
@onready var Door = get_tree().get_nodes_in_group("Door")
@onready var collision_shape_2d_2 = $StaticBody2D/CollisionShape2D2

# Called when the node enters the scene tree for the first time.
func _ready():
	Events.door_opened.connect(_on_body_entered)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	for k in Key:
		if k.has_key == true:
			door_open.visible = true
			door_closed.visible = false
			collision_shape_2d.set_deferred("disabled", true)
			collision_shape_2d_2.set_deferred("disabled", true)
