extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("grantInvincibility"):
		body.grantInvincibility(4)
	get_parent().queue_free()
