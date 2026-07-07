extends Area2D

var contains = 9

var max_dough = 8
var dough_left = max_dough

func use_dough():
	dough_left -= 1
	if dough_left <= 0:
		global_vars.can_bake = true
		$littleDough.hide()
	elif dough_left < 3:
		$someDough.hide()
	elif dough_left < 6:
		$allDough.hide()

func _on_mouse_entered():
	if not global_vars.dialogue_or_recipe_showing and dough_left > 0:
		global_vars.can_grab = true

func _on_mouse_exited():
	global_vars.can_grab = false

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		if not global_vars.dialogue_or_recipe_showing:
			if not global_vars.has_ingredient and dough_left > 0:
				global_vars.set_ingredient(contains)
				use_dough()
