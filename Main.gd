extends CanvasLayer

var settings = ["Mountains", "Beach", "City", "Harbour", "Alley", "Museum"]
var objects = ["Horse", "Couple", "Building", "Boat", "Car", "Skateboard", "Lincoln"]
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

func _ready():
	randomize()
	# Called when the node is added to the scene for the first time.
	# Initialization here
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
		else:
			$HUD/Label.set_text(customerRequests[randi()%customerRequests.size()])
	pass

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