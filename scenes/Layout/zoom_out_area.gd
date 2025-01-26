extends Area2D

class_name ZoomOutArea

@export var zoomAmount := 1.4

func _on_body_entered(body: Node2D) -> void:
	body.apply_zoom(zoomAmount)


func _on_body_exited(body: Node2D) -> void:
	body.reset_zoom()
