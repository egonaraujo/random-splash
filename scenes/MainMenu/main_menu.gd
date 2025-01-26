extends Control

class_name MainMenu

@export var soundOnTex :Texture2D
@export var soundOffTex: Texture2D

func _on_start_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Intro/Intro.tscn")

func _on_music_button_button_down() -> void:
	PlayerData.isMusicOn = !PlayerData.isMusicOn
	var texture = soundOnTex if PlayerData.isMusicOn else soundOffTex
	$MusicButton.texture_normal = texture
	$MusicButton.texture_pressed = texture

func _on_credits_button_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/Credits/Credits.tscn")
