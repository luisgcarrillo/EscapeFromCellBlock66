extends Resource
class_name LevelData

@export var Level_Number: int
@export var Level_Name: String
@export var Best_Time: float
@export var Star_Collected: bool

func _init(p_Level_Number = 0, p_Level_Name = "", p_Best_Time = 999999.0, p_Star_Collected = false ):
		Level_Number = p_Level_Number
		Level_Name = p_Level_Name
		Best_Time = p_Best_Time
		Star_Collected = p_Star_Collected
