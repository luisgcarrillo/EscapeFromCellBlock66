extends Node2D

@export var force = -500.0

@onready var animation_player = $AnimationPlayer


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.velocity.y = force
		SoundPlayer.play_sound(SoundPlayer.BOUNCE)
		animation_player.play("Bounce")
