extends StaticBody2D

var drink = "Beer"
var close_to_barrel = false
var get_drink = false

func _process(delta):
	if close_to_barrel == true:
		if Input.is_action_pressed("ACTION"):
				get_drink =  true
func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Label.text = drink
		$Label.visible = true
		close_to_barrel = true
		if get_drink == true:
			body.drink = drink
		print(body.drink)

func _on_Area2D_body_exited(body):
	yield(get_tree().create_timer(0.5), "timeout")
	$Label.visible = false
