extends StaticBody2D
var client = preload("res://Entities/Client.tscn")

func _on_Timer_timeout():
	if Global.hour >= 8:
		var c = client.instance()
		c.position.y = -64
		add_child(c)
	else:
		print("waiting")
