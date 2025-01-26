extends Control

@export var targetScene : PackedScene = null

func _on_voltar_button_down() -> void:
	get_tree().change_scene_to_packed(targetScene)
