extends Control

var timer = 5

func _ready() -> void:
	$Label.text = to_time(PlayerData.time)
	hideComicAfterTime()

func hideComicAfterTime() -> void:
	await get_tree().create_timer(timer).timeout
	$Comic.hide()

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
	finalString += "%05.2fs" % timeInSec
	return finalString

func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu/MainMenu.tscn")

func _on_next_button_button_down() -> void:
	$Comic.hide()
