extends Area2D

@onready var star_sprite = $StarSprite
@onready var world = $".."
@onready var collision_shape_2d = $CollisionShape2D

func _ready():
	star_sprite.visible = true
	collision_shape_2d.set_deferred("disabled", false)
	star_sprite.play("shine")
	

func _on_body_entered(body):
	Events.star_collected.emit()
	SoundPlayer.play_sound(SoundPlayer.STAR)
	star_sprite.visible = false
	collision_shape_2d.set_deferred("disabled", true)
	queue_free()
