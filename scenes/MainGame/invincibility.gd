extends Area2D

class_name Invincibility

signal powerup_collected

func _on_body_entered(body: Node2D) -> void:
	print(" body entered " + body.name)
	if body.has_method("grantInvincibility"):
		body.grantInvincibility(12)
	powerup_collected.emit(self)
