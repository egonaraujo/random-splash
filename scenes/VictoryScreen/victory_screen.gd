extends Control

func _ready() -> void:
	$Label.text = "Time: " + to_time(PlayerData.time)

func to_time(timeInSec:float) -> String:
	var hours = floor(timeInSec/3600)
	timeInSec -= hours * 3600
	var mins = floor(timeInSec / 60)
	timeInSec -= mins * 60
	
	var finalString = ""
	if hours > 0:
		finalString += "%02d:" % hours
	if mins > 0 || hours > 0: #display minutes 0 if hour is > 0
		finalString +=  "%02d:" % mins
	finalString += "%05.2f" % timeInSec
	return finalString

func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu/MainMenu.tscn")
