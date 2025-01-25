extends Node2D
class_name GameManager

var timer:float = 0

func _ready() -> void:
	timer = 0

func _on_player_player_died() -> void:
	get_tree().change_scene_to_file.bind("res://scenes/MainMenu/MainMenu.tscn").call_deferred()

func _process(delta: float) -> void:
	timer += delta
