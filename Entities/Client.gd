extends KinematicBody2D

var DRINKS = ["Water", "Beer", "Coconut Water", "Margarita", "Bloody Mary"]
var drink = "water"
var level_navigation : Navigation2D = null
var chair = null
var path : Array = []
var velocity = Vector2.ZERO
var speed = 250
#Change the customer graphics randomly every time they spawn
func _ready():
	_decide_drink()
	var tree = get_tree()
	print(tree)
	if tree.has_group("navigation"):
		print("Found it")
		level_navigation = tree.get_nodes_in_group("navigation")[0]
	
# Just here so i can cahnge the drink they want for debug purposes
func _process(delta):
	if Input.is_action_just_pressed("RELOAD"):
		_decide_drink()
		
func _physics_process(delta):
	if chair and level_navigation:
		generate_path()
		navigate()
	move()
	
func move():
	velocity = move_and_slide(velocity)
	
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
	
func navigate():
	if path.size() > 0:
		velocity =  global_position.direction_to(path[1]) * speed
		print("navigating path")
		
		if global_position == path[0]:
			path.pop_front()
			
func generate_path():
	print("Generated Path")
	if level_navigation != null and chair != null:
		path = level_navigation.get_simple_path(global_position, chair.global_position, false)

func _on_seat_area_body_entered(body):
	print("looking")
	var min_dist = 9999
	if body.is_in_group("seats"):
		print("Found a seat")
		var dist = self.position.distance_to(body.position)
		if (dist < min_dist):
			min_dist = dist
			chair = body
	return chair
