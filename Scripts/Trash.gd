extends TextureRect


var trash_open = load("res://Art/trashOpen.png")
var trash_closed = load("res://Art/trashClosed.png")

var trash_hover = false

func _process(_delta):
	if global_vars.dialogue_or_recipe_showing:
		self.visible = false
	elif not self.visible:
		self.visible = true


func _on_mouse_entered():
	if global_vars.current_ingredient != - 1:
		self.texture = trash_open
		trash_hover = true


func _on_mouse_exited():
	if trash_hover:
		trash_hover = false
		self.texture = trash_closed


func _on_gui_input(event):
	if (event is InputEventMouseButton and event.pressed):
		if global_vars.current_ingredient != - 1:
			global_vars.set_ingredient( - 1)
			trash_hover = false
			self.texture = trash_closed
			$sound.play()
