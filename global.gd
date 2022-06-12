extends Node

var minutes = 00
var hour = 07

func _process(delta):
	if minutes >= 60:
		hour += 01
		minutes = 00
