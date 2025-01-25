extends Control

class_name MainMenu

func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame/MainGame.tscn")

func _on_music_button_button_down() -> void:
	pass # Replace with function body.
