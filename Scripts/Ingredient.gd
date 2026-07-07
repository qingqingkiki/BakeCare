extends Area2D

@export var contains: int = - 1
@export var required_tool: int = - 1
@export var cup: bool = false

func _on_mouse_entered():
	if (global_vars.current_ingredient == required_tool or required_tool == -1 or global_vars.current_ingredient == -1) and not global_vars.dialogue_or_recipe_showing:
		global_vars.can_grab = true

func _on_mouse_exited():
	global_vars.can_grab = false

func _process(_delta):
	if cup and not self.visible and not global_vars.cup_ingredient:
		self.visible = true

func _on_input_event(_viewport, event, _shape_idx):
	if (event is InputEventMouseButton and event.pressed):
		if (global_vars.current_ingredient == required_tool or required_tool == -1 or global_vars.current_ingredient == -1) and not global_vars.dialogue_or_recipe_showing:
			global_vars.set_ingredient(contains)
			if cup:
				self.visible = false
