extends StaticBody2D

var drink = "Beer"
var can_interact = false
var player

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		$Label.text = drink
		$Label.visible = true
		can_interact = true
		print(body.drink)
		body = player

func _on_Area2D_body_exited(body):
	yield(get_tree().create_timer(0.5), "timeout")
	$Label.visible = false
	

