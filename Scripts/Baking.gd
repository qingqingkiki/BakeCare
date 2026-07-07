extends Control








func _ready():
	if not global_vars.seen_tutorial:
		global_vars.dialogue_to_show = [
			{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "哇，这么快就准备烤了？", "emotion": global_vars.EMOTIONS.surprise}, 
			{"text": "你真的很有天赋！", "emotion": global_vars.EMOTIONS.happy}, 
			{"text": "接下来这一步很简单。", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "先从碗里拿一些面团……", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "……再放到烤盘上！", "emotion": global_vars.EMOTIONS.happy}, 
			{"text": "等面团都放好以后……", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "……点击计时器就可以啦！", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "然后我们只要等饼干烤好。", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "出炉后我会来告诉你做得怎么样！", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "加油！", "emotion": global_vars.EMOTIONS.happy}, 
			{"text": "...", "emotion": global_vars.EMOTIONS.neutral}, 
			{"text": "（……别像我一样把它们烤焦哦……）", "emotion": global_vars.EMOTIONS.sigh}
		]
		$DialogueBox.visible = true






func _on_DialogueBox_text_finished():
	global_vars.seen_tutorial = true
