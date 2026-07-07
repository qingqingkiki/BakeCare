extends Area2D

var dough_on_sheet = 0

func add_dough():
	dough_on_sheet += 1
	var childNode = "doughBall" + str(dough_on_sheet)
	self.find_child(childNode).show()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and event.pressed and global_vars.current_ingredient > - 1:
		$sound.play()
		add_dough()
		global_vars.set_ingredient( - 1)
