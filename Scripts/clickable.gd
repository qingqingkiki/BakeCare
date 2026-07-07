extends Node

@export var click_override = false

func _on_mouse_entered():
	if not global_vars.dialogue_or_recipe_showing or click_override:
		global_vars.can_click = true


func _on_mouse_exited():
	if not global_vars.dialogue_or_recipe_showing or click_override:
		global_vars.can_click = false
