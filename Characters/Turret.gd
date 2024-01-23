extends StaticBody2D

@onready var pointer = $Pointer
@onready var ray_cast_2d = $Pointer/RayCast2D

@export var rotate_speed:= 90.0

@onready var player = $"../Player"

@export var bullet: PackedScene
@onready var reload_timer = $ReloadTimer
@onready var gun_sprite = $GunSprite
var can_shoot = true
var isShooting = false
var shotChoice = 0
func _ready():
	pass

func _process(delta):
	look_at(player.position)
	shoot()
	handle_animations()
	isShooting == false
	
func shoot():
	if ray_cast_2d.is_colliding() and can_shoot:
		if ray_cast_2d.get_collider().is_in_group("Player"):
			can_shoot = false
			isShooting = true
			reload_timer.start()
			var temp = bullet.instantiate()
			get_tree().current_scene.add_child(temp)
			temp.global_position = global_position
			temp.rotation_degrees = pointer.rotation_degrees - 180
			temp.set_bullet_direction(ray_cast_2d.get_collision_point() - position)
			if shotChoice == 0:
				SoundPlayer.play_sound(SoundPlayer.SHOT1)
				shotChoice = 1
			elif shotChoice == 1:
				SoundPlayer.play_sound(SoundPlayer.SHOT2)
				shotChoice = 0
			
		else:
			isShooting = false


func handle_animations():
	if isShooting == true:
		gun_sprite.play("shoot")
	else:
		gun_sprite.play("idle")
	

func _on_reload_timer_timeout():
	can_shoot = true
