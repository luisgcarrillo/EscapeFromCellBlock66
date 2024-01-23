extends Area2D


var in_door = false
@onready var sprite_2d = $Sprite2D
@onready var key = $"."
@export var has_key = false
@onready var collision_shape_2d = $CollisionShape2D


func _ready():
	has_key = false


func _on_body_entered(body):
	if body.name == "Player":
		SoundPlayer.play_sound(SoundPlayer.STAR)
		sprite_2d.visible = false
		key.monitoring = false
		collision_shape_2d.set_deferred("disabled", true)
		has_key = true


