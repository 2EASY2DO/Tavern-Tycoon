extends StaticBody2D

var DRINKS = ["Water", "Beer", "Coconut Water", "Margarita", "Bloody Mary"]
var drink = "water"
#Change the customer graphics randomly every time they spawn
func _ready():
	_decide_drink()
	
# Just here so i can cahnge the drink they want for debug purposes
func _process(delta):
	if Input.is_action_just_pressed("RELOAD"):
		_decide_drink()
		
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if body.drink == drink:
			$Label.text = "Thanks"
			$Label.visible = true
			body.drink = "none"
		else:
			$Label.text = drink
			$Label.visible = true
			print(body.drink)

func _on_Area2D_body_exited(body):
	yield(get_tree().create_timer(0.5), "timeout")
	$Label.visible = false

func _decide_drink():
	randomize()
	var drinkId = rand_range(0, 5)
	drink = DRINKS[drinkId]
