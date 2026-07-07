extends TextureRect


func _on_book_clicked(event):
	if (event is InputEventMouseButton and event.pressed) and not global_vars.dialogue_or_recipe_showing:
		global_vars.dialogue_or_recipe_showing = true
		global_vars.can_click = false
		global_vars.set_ingredient( - 1)
		self.visible = true
		$sound.play()

func _on_close(event):
	if (event is InputEventMouseButton and event.pressed):
		global_vars.can_click = false
		global_vars.dialogue_or_recipe_showing = false
		self.visible = false
		$sound_down.play()
