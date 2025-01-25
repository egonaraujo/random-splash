extends Sprite2D

@export var speed := 100.0
@export var maxDistance := 200.0

var _direction :int =-1
var _currentDistance :float =0

func _process(delta: float) -> void:
	var move_vec = Vector2(speed, 0).rotated(rotation)
	position += move_vec * delta * _direction
	_currentDistance += speed * delta
	if _currentDistance > maxDistance:
		_currentDistance *= -1 #max to one side so just multiply by -1
		_direction *= -1
		flip_h = !flip_h
