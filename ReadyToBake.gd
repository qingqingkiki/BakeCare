extends TextureRect

func _process(_delta):
	if global_vars.dialogue_or_recipe_showing:
		self.visible = false
	elif not self.visible:
		self.visible = true


func _on_mouse_entered():
	global_vars.can_click = true


func _on_mouse_exited():
	global_vars.can_click = false


func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		if not global_vars.dialogue_or_recipe_showing:
			global_vars.can_click = false
			get_tree().change_scene_to_file("res://Baking.tscn")
