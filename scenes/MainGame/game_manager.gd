extends Node2D
class_name GameManager

func _on_player_player_died() -> void:
	get_tree().change_scene_to_file.bind("res://scenes/MainMenu/MainMenu.tscn").call_deferred()
