extends CharacterBody2D

@export var movement_data : PlayerMovementData
@export var player_stats : PlayerStats
var dbl_jump = false
var just_wall_jumped = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_wall_normal = Vector2.ZERO
var old_axis
var old_y_velo
var can_flip = true

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_jump_timer = $CoyoteJumpTimer
@onready var starting_position = global_position
@onready var right_outer_ray = $RightOuterRay
@onready var right_inner_ray = $RightInnerRay
@onready var left_inner_ray = $LeftInnerRay
@onready var left_outer_ray = $LeftOuterRay
@onready var right_wall_ray = $RightWallRay
@onready var left_wall_ray = $LeftWallRay
@onready var switch_area = $"../SwitchArea"
@onready var switch_block = $"../SwitchBlock"
@onready var switch_block_collision = $"../SwitchBlock/CollisionShape2D"
@onready var jump_hold_timer = $JumpHoldTimer


func _physics_process(delta):
	apply_gravity(delta)
	handle_jump()
	var input_axis = Input.get_axis("left", "right")
	handle_wall_jump(input_axis, delta)
	handle_acceleration(input_axis, delta)
	handle_air_acceleration(input_axis, delta)
	apply_friction(input_axis, delta)
	apply_air_resistance(input_axis, delta)
	var was_on_floor = is_on_floor()
	var was_on_wall = is_on_wall_only()
	if was_on_wall:
		was_wall_normal = get_wall_normal()
	
	if right_outer_ray.is_colliding() and !right_inner_ray.is_colliding() \
		and !left_inner_ray.is_colliding() and !left_outer_ray.is_colliding() and velocity.y < 0 and abs(velocity.x) < 50:
			global_position.x -= 5
	elif !right_outer_ray.is_colliding() and !right_inner_ray.is_colliding() \
		and !left_inner_ray.is_colliding() and left_outer_ray.is_colliding() and velocity.y < 0 and abs(velocity.x) < 50:
			global_position.x += 5
	
	if right_wall_ray.is_colliding() and !left_wall_ray.is_colliding() and is_on_wall_only():
			global_position.x += .5
	elif !right_wall_ray.is_colliding() and left_wall_ray.is_colliding() and is_on_wall_only():
			global_position.x -= .5
	
	move_and_slide()
	var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
	if just_left_ledge:
		coyote_jump_timer.start()
	update_animations(input_axis)

func apply_gravity(delta):
	if not is_on_floor():
		if velocity.y < 0 and old_y_velo > velocity.y and dbl_jump == false:
			movement_data.gravity_scale = 1.2
		else:
			movement_data.gravity_scale = 1
		velocity.y += gravity * movement_data.gravity_scale * delta
		if Input.is_action_just_released("jump") and velocity.y < 0:
			velocity.y *= .5
		velocity.y = clamp(velocity.y, -5000, 350)
		old_y_velo = velocity.y


func handle_wall_jump(input_axis,delta):
	if not is_on_wall_only(): 
		can_flip = true
	elif is_on_wall_only():	
		var wall_normal = get_wall_normal()

		if Input.is_action_just_pressed("jump"):
			if input_axis == -1 and wall_normal.x == 1 and Input.is_action_just_pressed("jump"):
				velocity.x = lerp(velocity.x, wall_normal.x * (movement_data.speed * .20),1)
				velocity.y = movement_data.jump_velocity * 1.2
				SoundPlayer.play_sound(SoundPlayer.DBL_JUMP)
			elif input_axis == 1 and wall_normal.x == -1 and Input.is_action_just_pressed("jump"):
				velocity.x = lerp(velocity.x, wall_normal.x * (movement_data.speed * .20),1)
				velocity.y = movement_data.jump_velocity * 1.2

				SoundPlayer.play_sound(SoundPlayer.DBL_JUMP)
			else:
				velocity.x = lerp(velocity.x, wall_normal.x * (movement_data.speed * .75),1)
				velocity.y = movement_data.jump_velocity

				SoundPlayer.play_sound(SoundPlayer.DBL_JUMP)

		else:
			if velocity.y > 0:
				velocity.y = 30


func handle_jump():
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_pressed("jump"):
			velocity.y = movement_data.jump_velocity
			SoundPlayer.play_sound(SoundPlayer.JUMP)
			coyote_jump_timer.stop() 
	
	elif not is_on_floor() and not is_on_wall_only():
		if Input.is_action_just_pressed("jump") and dbl_jump:
			velocity.y = (movement_data.jump_velocity * .9)
			SoundPlayer.play_sound(SoundPlayer.DBL_JUMP)
			dbl_jump = false
		

func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		if input_axis == old_axis:
			velocity.x = lerp(velocity.x, movement_data.speed * input_axis, .05)
		elif input_axis != old_axis:
			velocity.x = velocity.x * .5
		old_axis = input_axis


func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration * delta)


func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction * delta)


func apply_air_resistance(input_axis, delta):
	if not is_on_floor():
		if input_axis == 0: return
		elif input_axis == 1:
			velocity.x = lerp(velocity.x, 0.0, .02)
		elif input_axis == -1:
			velocity.x = lerp(velocity.x,0.0,.02)


func update_animations(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis < 0)
		animated_sprite_2d.play("run")
	elif is_on_wall_only() and can_flip == true:
		flip_sprite(animated_sprite_2d)
		can_flip = false
	else:
		animated_sprite_2d.play("idle")
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func _on_hazard_detector_area_entered(area):
	velocity.x = 0
	velocity.y = 0
	global_position = starting_position
	SoundPlayer.play_sound(SoundPlayer.HURT)
	Events.player_died.emit()


func _on_end_detector_area_entered(area):
	Events.level_completed.emit()

func flip_sprite(AnimatedSprite2D):
	if AnimatedSprite2D.flip_h == false:
		AnimatedSprite2D.flip_h = true
		return
	elif AnimatedSprite2D.flip_h == true:
		AnimatedSprite2D.flip_h = false
		return




