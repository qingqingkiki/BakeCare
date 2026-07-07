extends Node


class RecipeIngredient:
	var name = ""
	var chance = 0
	var minAmount = 0
	var maxAmount = 0
	var unit = ""
	var enum_map = - 1
	func _init(name, chance, minAmount, maxAmount, unit, enum_map):
		self.name = name
		self.chance = chance
		self.minAmount = minAmount
		self.maxAmount = maxAmount
		self.unit = unit
		self.enum_map = enum_map

var all_ingredients = [
	RecipeIngredient.new("面粉", 1.0, 3, 5, "杯", INGREDIENTS.flour), 
	RecipeIngredient.new("白糖", 0.75, 1, 4, "杯", INGREDIENTS.sugar), 
	RecipeIngredient.new("鸡蛋", 1.0, 1, 3, "个", INGREDIENTS.egg), 
	RecipeIngredient.new("红糖", 0.5, 1, 3, "杯", INGREDIENTS.brown_sugar), 
	RecipeIngredient.new("黄油", 0.75, 1, 4, "块", INGREDIENTS.butter), 
	RecipeIngredient.new("香草精", 0.5, 1, 2, "勺", INGREDIENTS.vanilla), 
	RecipeIngredient.new("小苏打", 0.6, 1, 3, "勺", INGREDIENTS.soda), 
	RecipeIngredient.new("巧克力豆", 0.75, 1, 4, "杯", INGREDIENTS.chips)
]

enum EMOTIONS{
	happy, 
	sigh, 
	surprise, 
	neutral
}

var ingredients_in_bowl = []

var recipe = []

var dialogue_to_show = [
	{"text": "啊！有客人来了！", "emotion": EMOTIONS.surprise}, 
	{"text": "欢迎来到 CARE！这里的饼干永远超让人兴奋！", "emotion": EMOTIONS.happy}, 
	{"text": "嗯……？", "emotion": EMOTIONS.neutral}, 
	{"text": "哦！原来你是新员工！", "emotion": EMOTIONS.surprise}, 
	{"text": "很高兴认识你！我叫奇帕妮，叫我奇普就好。", "emotion": EMOTIONS.neutral}, 
	{"text": "...", "emotion": EMOTIONS.neutral}, 
	{"text": "……别问。（我妈妈取名很有想法……）", "emotion": EMOTIONS.sigh}, 
	{"text": "总之，欢迎来到 CARE 厨房！我来带你熟悉流程！", "emotion": EMOTIONS.happy}, 
	{"text": "客人会点定制饼干，我们负责把它们烤出来！", "emotion": EMOTIONS.neutral}, 
	{"text": "你只要照着食谱书上的配方来就行！", "emotion": EMOTIONS.neutral}, 
	{"text": "每一单的配方都会变，所以要看仔细哦！", "emotion": EMOTIONS.sigh}, 
	{"text": "需要量杯的时候，记得先拿量杯。", "emotion": EMOTIONS.neutral}, 
	{"text": "如果拿错了材料，就把它丢进垃圾桶吧！", "emotion": EMOTIONS.surprise}, 
	{"text": "准备好以后，点击“开始烘焙！”按钮！", "emotion": EMOTIONS.neutral}, 
	{"text": "好啦……就这些！祝你好运！我晚点来看看成果！", "emotion": EMOTIONS.happy}, 
	{"text": "（……忙起来，忙起来……）", "emotion": EMOTIONS.sigh}
]

var dialogue_or_recipe_showing = false
var can_grab = false
var can_click = false

var current_ingredient = - 1
var cup_ingredient = false

var can_bake = false

var seen_tutorial = false


var default_cursor = load("res://Art/mouse.png")
var grab_cursor = load("res://Art/hand.png")
var click_cursor = load("res://Art/point.png")


var butter = load("res://Art/butter.png")
var egg = load("res://Art/egg.png")
var cup = load("res://Art/cup.png")
var flour_cup = load("res://Art/cupFlour.png")
var chip_cup = load("res://Art/cupChips.png")
var brown_sugar_cup = load("res://Art/cupBrownSugar.png")
var sugar_cup = load("res://Art/cupSugar.png")
var soda = load("res://Art/sodaSpoon.png")
var vanilla = load("res://Art/vanillaSpoon.png")


var dough1 = load("res://Art/doughBall1.png")
var dough2 = load("res://Art/doughBall2.png")
var dough3 = load("res://Art/doughBall3.png")

var is_hand = false
var is_pointer = false
var has_ingredient = false

var rng = RandomNumberGenerator.new()

enum INGREDIENTS{
	egg, 
	flour, 
	sugar, 
	brown_sugar, 
	chips, 
	soda, 
	vanilla, 
	butter, 
	cup, 
	cookie_dough
}

func set_ingredient(ingredient):
	current_ingredient = ingredient
	if current_ingredient < 0:
		set_default_cursor()
		has_ingredient = false
	else:
		set_ingredient_cursor()
		has_ingredient = true
	match ingredient:
		INGREDIENTS.flour:
			cup_ingredient = true
		INGREDIENTS.brown_sugar:
			cup_ingredient = true
		INGREDIENTS.chips:
			cup_ingredient = true
		INGREDIENTS.sugar:
			cup_ingredient = true
		INGREDIENTS.cup:
			cup_ingredient = true
		_:
			cup_ingredient = false



func _ready():
	rng.randomize()
	get_window().min_size = Vector2(1100, 850)
	set_default_cursor()


func _process(_delta):
	if has_ingredient:
		pass
	else:
		if can_grab:
			if not is_hand:
				Input.set_custom_mouse_cursor(grab_cursor, Input.CURSOR_ARROW, Vector2(10, 10))
				is_hand = true
		elif is_hand:
				set_default_cursor()
				is_hand = false
		if can_click:
			if not is_pointer:
				Input.set_custom_mouse_cursor(click_cursor, Input.CURSOR_ARROW, Vector2(40, 5))
				is_pointer = true
		elif is_pointer:
			set_default_cursor()
			is_pointer = false

func pick_ingredients():
	print("PICKING TIME")
	recipe = []
	
	for potentialIngredient in all_ingredients:
		var random_chance = rng.randf()
		if (random_chance <= potentialIngredient.chance):
			var amount = rng.randi_range(potentialIngredient.minAmount, potentialIngredient.maxAmount)
			var recipe_item = {"ingredient": potentialIngredient, "amount": amount}
			recipe.push_back(recipe_item)

func set_default_cursor():
	Input.set_custom_mouse_cursor(default_cursor, Input.CURSOR_ARROW, Vector2())

func set_drag_cursor_default_vector(cursor, origin = Vector2()):
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, origin)

func set_ingredient_cursor():
	match current_ingredient:
		INGREDIENTS.brown_sugar:
			set_drag_cursor_default_vector(brown_sugar_cup, Vector2(100, 10))
		INGREDIENTS.butter:
			set_drag_cursor_default_vector(butter, Vector2(100, 50))
		INGREDIENTS.chips:
			set_drag_cursor_default_vector(chip_cup, Vector2(100, 10))
		INGREDIENTS.cookie_dough:
			var dough = rng.randi_range(1, 3)
			match dough:
				1:
					set_drag_cursor_default_vector(dough1, Vector2(40, 40))
				2:
					set_drag_cursor_default_vector(dough2, Vector2(40, 40))
				_:
					set_drag_cursor_default_vector(dough3, Vector2(40, 40))
		INGREDIENTS.cup:
			set_drag_cursor_default_vector(cup, Vector2(100, 10))
		INGREDIENTS.egg:
			set_drag_cursor_default_vector(egg, Vector2(45, 45))
		INGREDIENTS.flour:
			set_drag_cursor_default_vector(flour_cup, Vector2(100, 10))
		INGREDIENTS.soda:
			set_drag_cursor_default_vector(soda, Vector2(100, 10))
		INGREDIENTS.sugar:
			set_drag_cursor_default_vector(sugar_cup, Vector2(100, 10))
		INGREDIENTS.vanilla:
			set_drag_cursor_default_vector(vanilla, Vector2(80, 40))


