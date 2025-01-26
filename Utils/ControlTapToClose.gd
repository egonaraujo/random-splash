extends Control

@export var targetScene : PackedScene = null

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton && event.is_pressed():
		get_tree().change_scene_to_packed(targetScene)
