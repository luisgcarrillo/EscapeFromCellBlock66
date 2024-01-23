extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Events.change_scene.connect(_change_scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _change_scene(path_to_scene):
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var new_scene = load(path_to_scene).instantiate()
	add_child(new_scene)
