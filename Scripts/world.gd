extends Node2D

@onready var collision_polygon_2d = $StaticBody2D/CollisionPolygon2D
@onready var polygon_2d = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var level_completed = $CanvasLayer/LevelCompleted
@onready var player_sprite = $CanvasLayer/LevelCompleted/PlayerSprite
@onready var mid_timer = $CanvasLayer/LevelCompleted/PlayerSprite/MidscreenTimer
@export var next_level: PackedScene
@onready var switch_block = $SwitchBlock
@onready var switch_block_collision = $SwitchBlock/CollisionShape2D
@onready var camera_2d = $Camera2D
@onready var SwitchBlocks = get_tree().get_nodes_in_group("SwitchBlock")
@onready var Pickups = get_tree().get_nodes_in_group("Pickups")
@onready var switch_area = $SwitchArea
@onready var SwitchAreas = get_tree().get_nodes_in_group("SwitchAreas")
@onready var Key = get_tree().get_nodes_in_group("Key")
@onready var Door = get_tree().get_nodes_in_group("Door")
@onready var Stars = get_tree().get_nodes_in_group("Star")
@onready var star = $Star

@onready var start_in = $CanvasLayer/StartIn
@onready var start_in_label = $CanvasLayer/StartIn/VBoxContainer/CenterContainer/StartInLabel
@onready var countdown_player = $CountdownPlayer
@onready var level_num_label = $CanvasLayer/StartIn/VBoxContainer/CenterContainer/LevelNumLabel
@onready var animation_player = $AnimationPlayer

@onready var level_time_label = $CanvasLayer/CenterContainer/LevelTimeLabel
@onready var time_label = $CanvasLayer/LevelCompleted/CenterContainer/VBoxContainer/VBoxContainer/TimeLabel
@onready var best_time_label = $CanvasLayer/LevelCompleted/CenterContainer/VBoxContainer/VBoxContainer/BestTime
@onready var pause_menu = $CanvasLayer/PauseMenu

@export var _Level_Info: Resource
@export var level_number: int
@export var level_name: String

var start_level_msec = Time.get_ticks_msec()
var level_time = 0.0
var pause_timer = 0.0
var isPaused: bool
@onready var menu_button = $CanvasLayer/MenuButton
@onready var audio_stream_player = $AudioStreamPlayer

var best_time: float

@onready var tutorial_label_1 = $MovementTutorial/TutorialLabel1
@onready var tutorial_label_2 = $MovementTutorial2/TutorialLabel2
@onready var tutorial_label_3 = $MovementTutorial3/TutorialLabel3
@onready var tutorial_label_key = $KeyTutorial/TutorialLabelKey
@onready var sound_settings_menu = $CanvasLayer/SoundSettingsMenu
@onready var tutorial_label_dbl = $DBLJumpTutorial/TutorialLabelDBL
@onready var dbl_jump_tut_sprite = $DBLJumpTutSprite

var stop_timer: bool = false


func _ready():
	best_time = _Level_Info.Best_Time
	audio_stream_player.play(GlobalVars.musicProgress) 
	if _Level_Info.Star_Collected == true:
		for s in Stars:
				var star_collision = s.get_node("CollisionShape2D")
				var star_sprite = s.get_node("StarSprite")

				star_sprite.visible = false
				s.monitoring = false
				star_collision.set_deferred("disabled", true)
				
	Events.level_completed.connect(level_complete)
	Events.player_died.connect(player_died)
	Events.star_collected.connect(star_collected)
	
	level_num_label.text = "Level " + str(_Level_Info.Level_Number) + ": " + _Level_Info.Level_Name + "\n \n \n"
	menu_button.disabled = true
	isPaused = true
	get_tree().paused = true
	animation_player.play("Countdown")
	await animation_player.animation_finished
	get_tree().paused = false
	isPaused = false
	menu_button.disabled = false
	
	for i in SwitchBlocks:
		if i.visible == false:
			var thisBlockCollision = i.get_node("CollisionShape2D")
			thisBlockCollision.set_deferred("disabled", true)	

	start_level_msec = Time.get_ticks_msec()

func _process(delta):
	level_time = Time.get_ticks_msec() - start_level_msec
	level_time_label.text =  str(level_time / 1000.0)
	
	if Input.is_action_pressed("pause"):
		isPaused = true
		level_time -= Time.get_ticks_msec() - start_level_msec
		get_tree().paused = true
		pause_menu.visible = true

	handle_reset()


func save_best_time(value):
	_Level_Info.Best_Time = value

		
func level_complete():
	if (level_time / 1000.0) < (best_time):
		best_time = (level_time / 1000.0)
		save_best_time(best_time)
	level_completed.set_best_time(best_time)	
	level_completed.show()
	time_label.text = "Time: " + str(level_time / 1000.0)
	ResourceSaver.save(_Level_Info)
	get_tree().paused = true

func player_died():
	reset_timer()
	get_tree().call_group("Projectiles", "queue_free")
	for s in SwitchAreas:
		var switchRed = s.get_node("RedButton")
		var switchGreen = s.get_node("GreenButton")
	
		if switchGreen.visible == true:
			switchGreen.visible = false
			switchRed.visible = true
	
	for i in SwitchBlocks:
		if i.visible == false:
			i.visible = true
			var thisBlockCollision = i.get_node("CollisionShape2D")
			thisBlockCollision.set_deferred("disabled", false)
			
	for p in Pickups:
			var thisPickUpsArea = p.get_node("Area2D")
			var thisPickUpsSprite = p.get_node("AnimatedSprite2D")
			thisPickUpsSprite.visible = true
			thisPickUpsArea.monitoring = true
			var thisPickUpsCollision = p.get_node("Area2D/CollisionShape2D")
			thisPickUpsCollision.set_deferred("disabled", false)

	for k in Key:
		var key_collision = k.get_node("CollisionShape2D")
		var key_sprite = k.get_node("Sprite2D")
		
		k.has_key = false
		key_sprite.visible = true
		k.monitoring = true
		key_collision.set_deferred("disabled", false)

	for d in Door:
		var door_collision = d.get_node("CollisionShape2D")
		var door_sprite_open = d.get_node("DoorOpen")
		var door_sprite_closed = d.get_node("DoorClosed")
		var door_body = d.get_node("StaticBody2D/CollisionShape2D2")
		door_sprite_closed.visible = true
		door_sprite_open.visible = false
		d.monitoring = true
		door_collision.set_deferred("disabled", false)
		door_body.set_deferred("disabled", false)

func _on_switch_area_body_entered(body):
	for s in SwitchAreas:
		var switchRed = s.get_node("RedButton")
		var switchGreen = s.get_node("GreenButton")
	
		if switchRed.visible == true:
			switchRed.visible = false
			switchGreen.visible = true
		elif switchGreen.visible == true:
			switchGreen.visible = false
			switchRed.visible = true
	
	for i in SwitchBlocks:
		if i.visible == true:
			i.visible = false
			var thisBlockCollision = i.get_node("CollisionShape2D")
			thisBlockCollision.set_deferred("disabled", true)
		elif i.visible == false:
			i.visible = true
			var thisBlockCollision = i.get_node("CollisionShape2D")
			thisBlockCollision.set_deferred("disabled", false)

func star_collected():
	_Level_Info.Star_Collected = true

func go_to_next_level():
	if not next_level is PackedScene: return
	get_tree().change_scene_to_packed(next_level)
	get_tree().paused = false

func retry():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)

func _on_level_completed_next_level():
	go_to_next_level()

func handle_reset():
	if Input.is_action_just_pressed("retry"):
		retry()

func _on_unpause_pressed():
	pause_menu.visible = false
	isPaused = false
	menu_button.disabled = false
	get_tree().paused = false


func _on_restart_level_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file(scene_file_path)


func _on_main_menu_pressed():
	get_tree().paused = false
	pause_menu.visible = false
	get_tree().change_scene_to_file("res://Level/StartMenu.tscn")
	

func _on_quit_pressed():
	get_tree().quit()


func _on_menu_button_pressed():
		isPaused = true
		get_tree().paused = true
		menu_button.disabled = true
		pause_menu.visible = true

func reset_timer():
	pass


func _on_retry_level_pressed():
	retry()


func _on_movement_tutorial_body_entered(body):
	tutorial_label_1.visible = true


func _on_movement_tutorial_body_exited(body):
	tutorial_label_1.visible = false


func _on_movement_tutorial_2_body_entered(body):
	tutorial_label_2.visible = true


func _on_movement_tutorial_2_body_exited(body):
	tutorial_label_2.visible = false


func _on_movement_tutorial_3_body_entered(body):
	tutorial_label_3.visible = true


func _on_movement_tutorial_3_body_exited(body):
	tutorial_label_3.visible = false


func _on_sound_settings_pressed():
	pause_menu.visible = false
	sound_settings_menu.visible = true


func _on_pause_return_pressed():
	sound_settings_menu.visible = false
	isPaused = true
	pause_menu.visible = true


func _on_key_tutorial_body_entered(body):
	tutorial_label_key.visible = true
	


func _on_key_tutorial_body_exited(body):
	tutorial_label_key.visible = false


func _on_dbl_jump_tutorial_body_entered(body):
	tutorial_label_dbl.visible = true
	dbl_jump_tut_sprite.visible = true

func _on_dbl_jump_tutorial_body_exited(body):
	tutorial_label_dbl.visible = false
	dbl_jump_tut_sprite.visible = false
