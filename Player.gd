extends KinematicBody2D

export var speed := 700
var drink = "none"
func _physics_process(_delta:float) -> void:
	var input_vector:= Vector2(
		Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT"),
		Input.get_action_strength("DOWN") - Input.get_action_strength("UP")
	)
	var move_direction := input_vector.normalized()
	move_and_slide(speed * move_direction)
