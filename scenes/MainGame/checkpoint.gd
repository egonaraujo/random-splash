extends Area2D

signal player_entered_checkpoint

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("gainOxygen") :
		body.gainOxygen(100)
	player_entered_checkpoint.emit(self)
