extends Control

var cookie_grade = 0
var cookie_revealed = false

var dialogue_finished = false

var perfect_cookie_dialogue = [{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "哇，这批饼干太棒了！", "emotion": global_vars.EMOTIONS.happy}, 
{"text": "我等不及要把它们拿给客人了！", "emotion": global_vars.EMOTIONS.happy}, 
{"text": "他们一定会……超级开心！", "emotion": global_vars.EMOTIONS.happy}]
var small_cookie_dialogue = [{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "看起来好像少放了一些材料……", "emotion": global_vars.EMOTIONS.surprise}, 
{"text": "下次一定要仔细看食谱哦！", "emotion": global_vars.EMOTIONS.neutral}]
var wide_cookie_dialogue = [{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "看起来只有几样东西不太对……", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "已经很接近啦，下次一定可以！", "emotion": global_vars.EMOTIONS.happy}]
var burnt_cookie_dialogue = [{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "你……你真的看食谱了吗？", "emotion": global_vars.EMOTIONS.surprise}, 
{"text": "好……好吧，下次小心一点。", "emotion": global_vars.EMOTIONS.neutral}, 
{"text": "（又有材料要进垃圾桶了……）", "emotion": global_vars.EMOTIONS.sigh}]


func _ready():
	Music.find_child("Music").set_stream_paused(true)
	cookie_grade = grade_cookie()
	global_vars.seen_tutorial = true

func _process(_delta):
	if Input.is_action_just_pressed("ui_accept") and cookie_revealed and not dialogue_finished and not $DialogueBox.visible:
		$DialogueBox.show()
		$Cookies/arrow.hide()

func grade_cookie():
	var recipe_map = {global_vars.INGREDIENTS.brown_sugar: 0, 
		global_vars.INGREDIENTS.butter: 0, 
		global_vars.INGREDIENTS.chips: 0, 
		global_vars.INGREDIENTS.egg: 0, 
		global_vars.INGREDIENTS.flour: 0, 
		global_vars.INGREDIENTS.soda: 0, 
		global_vars.INGREDIENTS.sugar: 0, 
		global_vars.INGREDIENTS.vanilla: 0
	}
	var bowl_map = {global_vars.INGREDIENTS.brown_sugar: 0, 
		global_vars.INGREDIENTS.butter: 0, 
		global_vars.INGREDIENTS.chips: 0, 
		global_vars.INGREDIENTS.egg: 0, 
		global_vars.INGREDIENTS.flour: 0, 
		global_vars.INGREDIENTS.soda: 0, 
		global_vars.INGREDIENTS.sugar: 0, 
		global_vars.INGREDIENTS.vanilla: 0
	}
	
	for ingredient in global_vars.recipe:
		recipe_map[ingredient.ingredient.enum_map] = ingredient.amount
	
	for ingredient in global_vars.ingredients_in_bowl:
		print(ingredient)
		bowl_map[ingredient] += 1
		print(bowl_map)
	
	var difference = 0
	
	for ingredient_id in recipe_map.keys():
		difference += abs(recipe_map[ingredient_id] - bowl_map[ingredient_id])
	
	if difference <= 1:
		return 1.0
	elif difference <= 3:
		return 0.8
	elif difference <= 5:
		return 0.6
	else:
		return 0.0
	

func cookie_reveal():
	if cookie_grade < 0.5:
		$Cookies/burntCookie.show()
		global_vars.dialogue_to_show = burnt_cookie_dialogue
		$Fail.play()
	elif cookie_grade < 0.7:
		$Cookies/smallCookie.show()
		global_vars.dialogue_to_show = small_cookie_dialogue
		$Meh.play()
	elif cookie_grade < 0.9:
		$Cookies/wideCookie.show()
		global_vars.dialogue_to_show = wide_cookie_dialogue
		$OK.play()
	else:
		$Cookies/perfectCookie.show()
		global_vars.dialogue_to_show = perfect_cookie_dialogue
		$Happy.play()

func _on_Timer_timeout():
	$time_end.play()
	$Reveal.start()


func _on_Reveal_timeout():
	$drumroll.play()


func _on_drumroll_finished():
	$FinalReveal.start()


func _on_FinalReveal_timeout():
	cookie_reveal()
	$ArrowTimer.start()

func _on_ArrowTimer_timeout():
	cookie_revealed = true
	$Cookies/arrow.show()


func _on_DialogueBox_text_finished():
	dialogue_finished = true
	$PlayAgain.show()
	$Quit.show()
