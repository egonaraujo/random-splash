extends Node2D

@export var power : float = 100
@export var minRadius : float = 50
@export var maxRadius : float = 200

@onready var character := $RigidBody2D

func _process(delta:float) -> void:
	if Input.is_mouse_button_pressed(1):
		#queue_redraw() #uncomment to get gizmos
		var direction:Vector2 = character.global_position - get_global_mouse_position()
		
		# Does not have an effect if bigger than max radius
		if direction.length() > maxRadius:
			return
		
		var distance = clamp(direction.length(), minRadius, maxRadius)
		
		# if close to max, close to 0, if close to min, close to power
		# ease to make the force logarithmic instead of lin
		var boostStrength = remap(distance, minRadius, maxRadius, 1, 0)
		var boost = direction.normalized() * power * boostStrength
		character.apply_central_force(boost)

func _draw() -> void:
	return #comment to get gizmos
	draw_circle(get_global_mouse_position(), maxRadius, Color.DARK_BLUE)
	draw_circle(get_global_mouse_position(), minRadius, Color.AQUA)
