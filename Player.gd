extends KinematicBody2D

export var speed := 700
var drink = "none"
var can_interact = false
var new_drink

func _physics_process(_delta:float) -> void:
	var input_vector:= Vector2(
		Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT"),
		Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	)
	var move_direction := input_vector.normalized()
	move_and_slide(speed * move_direction)
	
func _on_Area2D_body_entered(body):
	if body.name == "Barrel":
		can_interact = true
		new_drink = body.drink
		
func _on_Area2D_body_exited(body):
	can_interact = false
	new_drink = null
	
func _input(event):
	if Input.is_action_pressed("ACTION") && can_interact == true:
		drink = new_drink
		print(drink)
