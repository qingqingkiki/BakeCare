extends Control



func _ready():
	Music.find_child("Music").set_stream_paused(false)
	if not global_vars.seen_tutorial:
		$DialogueBox.show()
	global_vars.pick_ingredients()
	global_vars.ingredients_in_bowl = []



