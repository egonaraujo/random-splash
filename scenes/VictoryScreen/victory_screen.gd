extends Control

func _ready() -> void:
	$Label.text = "Time: " + to_time(PlayerData.time)

func to_time(timeInSec:float) -> String:
	var hours = floor(timeInSec/3600)
	timeInSec -= hours * 3600
	var mins = floor(timeInSec / 60)
	timeInSec -= mins * 60
	
	var string = "%02d:%02d:%05.2f"
	return string % [hours, mins, timeInSec]


func _on_restart_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainMenu/MainMenu.tscn")
