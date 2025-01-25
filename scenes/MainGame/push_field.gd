extends Sprite2D

@export var direction : Vector2 = Vector2(-1,1)
@export var force : float = 10

var _affectedBody : RigidBody2D

func _on_push_field_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		_affectedBody = body
		print("affected body is " + body.name)

func _on_push_field_body_exited(body: Node2D) -> void:
	_affectedBody = null


func _process(delta: float) -> void:
	if _affectedBody == null:
		return
	_affectedBody.apply_central_force(direction*force)
	print("caused force on body")
