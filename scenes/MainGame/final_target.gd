extends Area2D
class_name FinalTarget

signal player_reached_target

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		player_reached_target.emit()
	
