extends MarginContainer



@onready var start_game_button = %StartGameButton

func _ready():
	start_game_button.grab_focus()

func _on_start_game_button_pressed():
	Events.change_scene.emit("res://Level/level6.tscn")


func _on_quit_game_button_pressed():
	get_tree().quit()


func _on_level_select_pressed():
	Events.change_scene.emit("res://Level/level_select.tscn")


func _on_options_pressed():
	Events.change_scene.emit("res://Level/OptionsScreen.tscn")
