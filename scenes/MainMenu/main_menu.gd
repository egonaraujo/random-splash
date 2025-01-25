extends Control

class_name MainMenu

func _on_comecar_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/MainGame/MainGame.tscn")

func _on_sair_button_pressed() -> void:
	get_tree().quit()
