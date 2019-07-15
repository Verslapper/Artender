extends CanvasLayer

var settings = ["Mountains", "Beach", "City", "Harbour", "Alley", "Museum"]
var objects = ["Horse", "Couple", "Building", "Boat", "Car", "Skateboard", "Lincoln"]
var modifiers = ["Dunce Cap", "Scarf", "Censored Sticker", "Megaphone", "Sunnies", "Mayoral Sash"]
var genders = ["male", "female", "genderfluid", "attack helicopter"]
var introText = ["It's your first day as a bartender here!", "This is no ordinary bar, though.",
	"Here, patrons come for unique, creative expressions on canvas, not just drinks.",
	"Do your best to create a masterpiece, and they'll tip you accordingly.",
	"Oh look, here comes your first customer!", "Good luck, artender!"]
var introIndex = 0
var elapsed = 0

func _ready():
	randomize()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	elapsed += delta
	
	if (elapsed > 8 && introIndex == 0):
		$HUD/Label.set_text("Welcome!\n\n[press space to advance]")
	
	if Input.is_action_just_pressed("ui_accept") && introIndex < introText.size():
		$HUD/Label.set_text(introText[introIndex])
		introIndex += 1
	pass

func generateCustomer():
	var age = rand_range(5,95)
	var gender = genders[randi()%genders.size()]
	
	pass