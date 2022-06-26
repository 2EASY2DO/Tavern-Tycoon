extends KinematicBody2D

var DRINKS = ["Water", "Beer", "Coconut Water", "Margarita", "Bloody Mary"]
var drink = "water"
var level_navigation : Navigation2D = null
var chair = null
var path : Array = []
var velocity = Vector2.ZERO
var speed = 250
var walking = false

#Change the customer graphics randomly every time they spawn
func _ready():
	_decide_drink()
	get_closest_seat()
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
		walking = true
	move()
	
func move():
	if chair and chair.free == false:
		get_closest_seat()
	velocity = move_and_slide(velocity)
	
func _on_Area2D_body_entered(body):
	if body == chair:
		body.free = false
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
		
		if global_position == path[0]:
			path.pop_front()
			
func generate_path():
	if level_navigation != null and chair != null:
		path = level_navigation.get_simple_path(global_position, chair.global_position, false)

func get_closest_seat():
	var min_dist = 99999
	var min_seat
	var seats = get_tree().get_nodes_in_group("seats")
	for seat in seats:
		var dist = self.position.distance_to(seat.position)
		if (dist < min_dist and seat.free == true):
			min_dist = dist
			min_seat = seat
	chair = min_seat
