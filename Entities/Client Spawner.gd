extends KinematicBody2D
var clienta = preload("res://Entities/Clients/Client_A.tscn")
var clientb = preload("res://Entities/Clients/Client_B.tscn")

func _on_Timer_timeout():
	if Global.hour >= 8:
		print("OnTime")
		randomize()
		if rand_range(0, 2) <= 1:
			var c = clienta.instance()
			c.position.y = -64
			add_child(c)
			print("Man")
		else:
			var c = clientb.instance()
			c.position.y = -64
			add_child(c)
			print("Woman")
	else:
		print("waiting")
