extends Node2D

@onready var Pickups = get_tree().get_nodes_in_group("Pickups")
@onready var area_2d = $Area2D
@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var animated_sprite_2d = $AnimatedSprite2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.dbl_jump = true
		animated_sprite_2d.visible = false
		area_2d.monitoring = false
		collision_shape_2d.set_deferred("disabled", true)
