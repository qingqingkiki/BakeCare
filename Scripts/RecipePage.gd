extends TextureRect

func load_recipe():
	var recipe = global_vars.recipe
	var recipe_text = ""
	for ingredient in recipe:
		recipe_text += str(ingredient.amount)
		var unit = ingredient.ingredient.unit
		var name = ingredient.ingredient.name
		recipe_text += unit
		recipe_text += name
		recipe_text += "\n\n"
	recipe_text.strip_escapes()
	$ReceipeContents.text = recipe_text

func _on_book_clicked(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed) and not global_vars.dialogue_or_recipe_showing:
		global_vars.dialogue_or_recipe_showing = true
		global_vars.can_click = false
		global_vars.set_ingredient( - 1)
		self.visible = true
		$sound.play()

func _on_close():
	global_vars.can_click = false
	global_vars.dialogue_or_recipe_showing = false
	self.visible = false
	$sound_down.play()


func _on_wait_to_load_timeout():
	load_recipe()
