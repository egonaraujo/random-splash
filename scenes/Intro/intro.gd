extends Control

var state = 0

func _on_next_button_down() -> void:
	match state:
		0:
			$Quadrinho1.hide()
			$Quadrinho2.show()
		1:
			get_tree().change_scene_to_file("res://scenes/Layout/GameLayout2.tscn")
	state +=1
