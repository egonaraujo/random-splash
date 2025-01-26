extends Control

class_name MainMenu

func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame/MainGame.tscn")

func _on_music_button_button_down() -> void:
	PlayerData.isMusicOn = !PlayerData.isMusicOn


func _on_credits_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Credits/Credits.tscn")
