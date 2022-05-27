extends Area2D

func _on_Box_body_entered(body):
	if body.name == "Player":
		body.drink = "Beer"
		print(body.drink)
