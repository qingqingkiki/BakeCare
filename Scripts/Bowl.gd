extends Area2D








func _ready():
	pass







func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and global_vars.current_ingredient > - 1:
		if not global_vars.current_ingredient == global_vars.INGREDIENTS.cup:
			$sound.play()
			print(global_vars.ingredients_in_bowl)
			global_vars.ingredients_in_bowl.append(global_vars.current_ingredient)
			print(global_vars.ingredients_in_bowl)
		global_vars.set_ingredient( - 1)
