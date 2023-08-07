extends Area2D


var movement_direction := Vector2.ZERO
@export var Speed: int = 200
@onready var bullet_sprite = $BulletSprite


func _physics_process(delta):
	position += movement_direction.normalized() * Speed * delta
	handle_animation()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func handle_animation():
	bullet_sprite.play("default")
	
func set_bullet_direction(point_direction: Vector2)->void:
	movement_direction = point_direction
	

func _on_body_entered(body):
	if body.name == "LevelTileMap":
		queue_free()
	if body.name.contains("SwitchBlock"):
		queue_free() # Replace with function body.
