extends Control

var level_path: String
@onready var level_info = $Label/LevelInfo
var level1 = load("res://Resources/Level1Resource.tres")
var level2 = load("res://Resources/Level2Resource.tres")
var level3 = load("res://Resources/Level3Resource.tres")
var level4 = load("res://Resources/Level4Resource.tres")
var level5 = load("res://Resources/Level5Resource.tres")
var level6 = load("res://Resources/Level6Resource.tres")
var level7 = load("res://Resources/Level7Resource.tres")
var level8 = load("res://Resources/Level8Resource.tres")
var StarVar: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://Level/level6.tscn")


func _on_level_1_mouse_entered():
	if level1.Star_Collected ==  false:
		StarVar = "No"
	elif level1.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level1.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level1.Level_Number) + ": " + level1.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level1.Level_Number) + ": " + level1.Level_Name + "\n"  + "Best Time: " + str(level1.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://Level/level5.tscn")


func _on_level_2_mouse_entered():
	if level2.Star_Collected ==  false:
		StarVar = "No"
	elif level2.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level2.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level2.Level_Number) + ": " + level2.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level2.Level_Number) + ": " + level2.Level_Name + "\n"  + "Best Time: " + str(level2.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_3_pressed():
	get_tree().change_scene_to_file("res://Level/level4.tscn")


func _on_level_3_mouse_entered():
	if level3.Star_Collected ==  false:
		StarVar = "No"
	elif level3.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level3.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level3.Level_Number) + ": " + level3.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level3.Level_Number) + ": " + level3.Level_Name + "\n"  + "Best Time: " + str(level3.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_4_pressed():
	get_tree().change_scene_to_file("res://Level/level_12.tscn")


func _on_level_4_mouse_entered():
	if level4.Star_Collected ==  false:
		StarVar = "No"
	elif level4.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level4.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level4.Level_Number) + ": " + level4.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level4.Level_Number) + ": " + level4.Level_Name + "\n"  + "Best Time: " + str(level4.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_5_pressed():
	get_tree().change_scene_to_file("res://Level/level8.tscn")


func _on_level_5_mouse_entered():
	if level5.Star_Collected ==  false:
		StarVar = "No"
	elif level5.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level5.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level5.Level_Number) + ": " + level5.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level5.Level_Number) + ": " + level5.Level_Name + "\n"  + "Best Time: " + str(level5.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_6_pressed():
	get_tree().change_scene_to_file("res://Level/level7.tscn")


func _on_level_6_mouse_entered():
	if level6.Star_Collected ==  false:
		StarVar = "No"
	elif level6.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level6.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level6.Level_Number) + ": " + level6.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level6.Level_Number) + ": " + level6.Level_Name + "\n"  + "Best Time: " + str(level6.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_7_pressed():
	get_tree().change_scene_to_file("res://Level/level3.tscn")


func _on_level_7_mouse_entered():
	if level7.Star_Collected ==  false:
		StarVar = "No"
	elif level7.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level7.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level7.Level_Number) + ": " + level7.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" + "Star Collected: " + StarVar
	else:
		level_info.text = "Level "+ str(level7.Level_Number) + ": " + level7.Level_Name + "\n"  + "Best Time: " + str(level7.Best_Time) + "\n" + "Star Collected: " + StarVar


func _on_level_8_pressed():
	get_tree().change_scene_to_file("res://Level/level9.tscn")


func _on_level_8_mouse_entered():
	if level8.Star_Collected ==  false:
		StarVar = "No"
	elif level8.Star_Collected ==  true:
		StarVar = "Yes"
	
	if level8.Best_Time >= 10000.0:
		level_info.text = "Level "+ str(level8.Level_Number) + ": " + level8.Level_Name + "\n"  + "Best Time: " + "N/A" + "\n" 
	else:
		level_info.text = "Level "+ str(level8.Level_Number) + ": " + level8.Level_Name + "\n"  + "Best Time: " + str(level8.Best_Time) + "\n" 


func _on_back_to_main_menu_pressed():
	get_tree().change_scene_to_file("res://Level/StartMenu.tscn")
