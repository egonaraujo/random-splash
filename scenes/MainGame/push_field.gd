extends Sprite2D

@export var direction : Vector2 = Vector2(-1,1)
@export var force : float = 10
@export var oxygenGainPerSecond: float = 5

var _affectedBody : RigidBody2D

func _on_push_field_body_entered(body: Node2D) -> void:
	if body is RigidBody2D:
		_affectedBody = body

func _on_push_field_body_exited(_body: Node2D) -> void:
	_affectedBody = null


func _physics_process(delta: float) -> void:
	if _affectedBody == null:
		return
	_affectedBody.apply_central_force(direction*force)

	if _affectedBody.has_method("gainOxygen"):
		_affectedBody.gainOxygen(oxygenGainPerSecond*delta)
