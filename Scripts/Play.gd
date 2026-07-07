extends TextureButton


func _on_mouse_entered():
	global_vars.can_click = true


func _on_mouse_exited():
	global_vars.can_click = false


func _on_gui_input():
	if not global_vars.dialogue_or_recipe_showing:
		global_vars.can_click = false
		get_tree().change_scene_to_file("res://Main.tscn")
