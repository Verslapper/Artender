extends CanvasLayer

var settings = ["Mountains", "Beach", "City", "Harbour", "Alley", "Museum"]
var objects = ["Horse", "People", "Building", "Boat", "Car", "Skateboard", "Lincoln"]
var modifiers = ["Dunce Cap", "Scarf", "Censored Sticker", "Megaphone", "Sunnies", "Mayoral Sash"]
var genders = ["male", "female", "genderfluid", "attack helicopter"]
var introText = ["It's your first day as a bartender here!", "This is no ordinary bar, though.",
	"Here, patrons come for unique expressions on canvas, not just drinks.",
	"Do your best to create a masterpiece, and they'll tip you accordingly.",
	"Oh look, here comes your first customer!", "Good luck, artender!"]
var introIndex = 0
var elapsedSeconds = 0
var piecesCompleted = 0
var tips = 0
var customerAge = 0
var customerGender = ""
var customerRequests = ["One art, please.", "Create something delightful for me please, barkeep!",
"Show me your world, artender.", "Make me feel something in my cold, dead heart."]
var customerReactions = ["Thanks, I hate it.", "I don't know much about art, but I know what I like.",
"This reminds me of my youth.", "It's like you painted my dream.",
"I've never felt so alive!", "I want a tattoo of this!"]
var easelMode = false
var optionLeft = ""
var optionUp = ""
var optionRight = ""
var selectedSetting = ""
var selectedObject = ""
var selectedModifier = ""
var mountains = preload("assets/Mountains.png")
var beach = preload("assets/Beach.png")

func _ready():
	$EaselHUD.layer = 0
	randomize()
	pass

func _process(delta):
	elapsedSeconds += delta
	
	# Action prompt
	if (elapsedSeconds > 8 && introIndex == 0):
		$HUD/Label.set_text("Welcome!\n\n[press space to advance]")
	
	# Intro text progression sequence
	if Input.is_action_just_pressed("ui_accept") && introIndex < introText.size():
		$HUD/Label.set_text(introText[introIndex])
		introIndex += 1
	
	# Customer progression sequence
	if Input.is_action_just_pressed("ui_accept") && introIndex >= introText.size():
		if (customerAge == 0):
			generateCustomer()
		elif easelMode == false:
			$HUD/Label.set_text(customerRequests[randi()%customerRequests.size()])
			easelMode = true
		else:
			startEasel()
	pass
	
	if easelMode && Input.is_action_just_pressed("ui_left"):
		if (selectedSetting == ""):
			selectedSetting = optionLeft
			startEasel()
		elif (selectedObject == ""):
			selectedObject = optionLeft
			startEasel()
		elif (selectedModifier == ""):
			selectedModifier = optionLeft
			finishEasel()
		pass
	
	if easelMode && Input.is_action_just_pressed("ui_up"):
		if (selectedSetting == ""):
			selectedSetting = optionUp
			startEasel()
		elif (selectedObject == ""):
			selectedObject = optionUp
			startEasel()
		elif (selectedModifier == ""):
			selectedModifier = optionUp
			finishEasel()
		pass
	
	if easelMode && Input.is_action_just_pressed("ui_right"):
		if (selectedSetting == ""):
			selectedSetting = optionRight
			startEasel()
		elif (selectedObject == ""):
			selectedObject = optionRight
			startEasel()
		elif (selectedModifier == ""):
			selectedModifier = optionRight
			finishEasel()
		pass
	
	# Man, how the hell do I load images programatically?
	if (selectedSetting != ""):
		var spritefrompreload = Sprite.new()
		spritefrompreload.set_texture(mountains)
		$EaselHUD/PaintingCanvas.add_child(spritefrompreload)
		

func generateCustomer():
	customerAge = rand_range(5,95)
	
	# Dramatically reveal the absurdity
	if (piecesCompleted < genders.size()):
		customerGender = genders[piecesCompleted]
	else:
		customerGender = genders[randi()%genders.size()]
		
	$HUD/Label.set_text("A " + str(round(customerAge)) + "-year-old " + customerGender + " approaches the bar.")
	elapsedSeconds = 0 #reset [press space to advance] prompt
	
	pass
	
func startEasel():
	# set easel background
	$EaselHUD.layer = 3
	$EaselHUD/PaintingCanvas.layer = 1
	$HUD/TipLabel.set_text("$" + str(tips))
	# present three options
	if (selectedSetting == ""):
		$EaselHUD/QuestionLabel.set_text("What is the setting for your piece?")
		optionLeft = settings[randi()%settings.size()]
		optionUp = settings[randi()%settings.size()]
		while (optionUp == optionLeft):
			optionUp = settings[randi()%settings.size()]
		optionRight = settings[randi()%settings.size()]
		while (optionRight == optionLeft || optionRight == optionUp):
			optionRight = settings[randi()%settings.size()]
			
	elif (selectedObject == ""):
		$EaselHUD/QuestionLabel.set_text("What is your centrepiece?")
		optionLeft = objects[randi()%objects.size()]
		optionUp = objects[randi()%objects.size()]
		while (optionUp == optionLeft):
			optionUp = objects[randi()%objects.size()]
		optionRight = objects[randi()%objects.size()]
		while (optionRight == optionLeft || optionRight == optionUp):
			optionRight = objects[randi()%objects.size()]
			
	elif (selectedModifier == ""):
		$EaselHUD/QuestionLabel.set_text("What is your finisher?")
		optionLeft = modifiers[randi()%modifiers.size()]
		optionUp = modifiers[randi()%modifiers.size()]
		while (optionUp == optionLeft):
			optionUp = modifiers[randi()%modifiers.size()]
		optionRight = modifiers[randi()%modifiers.size()]
		while (optionRight == optionLeft || optionRight == optionUp):
			optionRight = modifiers[randi()%modifiers.size()]
	
	$EaselHUD/AnswerLeftLabel.set_text(optionLeft)
	$EaselHUD/AnswerUpLabel.set_text(optionUp)
	$EaselHUD/AnswerRightLabel.set_text(optionRight)
	pass
	
func finishEasel():
	$EaselHUD.layer = 0
	$EaselHUD/PaintingCanvas.layer = 0
	var rand = randi()%customerReactions.size()
	$HUD/Label.set_text(customerReactions[rand])
	var tip = rand * 10 + rand + 1
	tips += tip
	$HUD/TipLabel.set_text("$" + str(tips) + " (+$" + str(tip) + ")")
	easelMode = false
	customerAge = 0
	selectedSetting = ""
	selectedObject = ""
	selectedModifier = ""
	piecesCompleted += 1
	pass