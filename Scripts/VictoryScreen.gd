extends Control

@onready var level_tile_map = $LevelTileMap
@onready var center_container = $ColorRect/CenterContainer
@onready var victory_animation = $ColorRect/CenterContainer/VictoryAnimation
@onready var audio_stream_player = $AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.play()
	victory_animation.play("victory")
	await victory_animation.animation_finished
	center_container.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Level/StartMenu.tscn")


func _on_exit_game_pressed():
	get_tree().quit()
