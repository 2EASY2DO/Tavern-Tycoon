extends NinePatchRect


func _on_Timer_timeout():
	Global.minutes = Global.minutes + 01
	$Label.text = str(Global.hour) + ":" + str(Global.minutes)
