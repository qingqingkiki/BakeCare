extends Control

signal text_finished


var dialogue_index = 0
var finished = false
var loaded = false

var wait_for_scene_load = true

const normal_text = 1
const fast_text = 0.5

var portraits
var active_tween

func _ready():
	portraits = $TextureRect/Portraits.get_children()

func _process(_delta):
	if self.visible and not loaded and not wait_for_scene_load:
		loaded = true
		load_dialog()
	if Input.is_action_just_pressed("ui_accept") and not wait_for_scene_load and self.visible:
		$sound.play()
		load_dialog()

func load_dialog():
	if dialogue_index < global_vars.dialogue_to_show.size():
		global_vars.dialogue_or_recipe_showing = true;
		hide_portraits()
		finished = false
		$Arrow.visible = false
		$RichTextLabel.visible_ratio = 0
		var text_to_display = global_vars.dialogue_to_show[dialogue_index].text
		$RichTextLabel.text = text_to_display
		$TextureRect/Portraits.find_child(get_emotion(global_vars.dialogue_to_show[dialogue_index].emotion)).visible = true
		var text_speed
		if text_to_display.length() < 30:
			text_speed = fast_text
		else:
			text_speed = normal_text
		if active_tween:
			active_tween.kill()
		active_tween = create_tween()
		active_tween.tween_property($RichTextLabel, "visible_ratio", 1, text_speed)
		active_tween.finished.connect(_on_tween_finished)
		dialogue_index += 1
	else:
		global_vars.dialogue_or_recipe_showing = false;
		emit_signal("text_finished")
		queue_free()

func get_emotion(emotion):
	match emotion:
		global_vars.EMOTIONS.happy:
			return "happy"
		global_vars.EMOTIONS.surprise:
			return "surprised"
		global_vars.EMOTIONS.sigh:
			return "sigh"
		_:
			return "neutral"

func hide_portraits():
	for portrait in portraits:
		portrait.visible = false

func _on_tween_finished():
	$Arrow.visible = true
	finished = true


func _on_Timer_timeout():
	wait_for_scene_load = false
