extends RigidBody2D

@export_group("Click Input")
@export var power : float = 100
@export var minRadius : float = 50
@export var maxRadius : float = 200

@export_group("Oxygen Control")
@export var oxygen : float = 100
@export var oxygenLossPerSec: float = 0.5
@export var oxygenLossPerImpact: float = 20

@onready var originalSpriteScale:Vector2 = $Sprite.scale
@onready var originalColliderScale:Vector2 = $CollisionShape2D.scale

#Signals
signal player_died()

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1
	

func _process(delta:float) -> void:
	processOxygen(delta)
	processInput()

func processOxygen(delta:float) -> void:
	oxygen -= oxygenLossPerSec * delta
	if oxygen <= 0:
		emit_signal("player_died")
	var oxygenScale = remap(oxygen, 0, 100, 0.2, 1)
	$Sprite.scale = oxygenScale * originalSpriteScale
	$CollisionShape2D.scale = oxygenScale * originalColliderScale

func processInput() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#queue_redraw() #uncomment to get gizmos
		var direction:Vector2 = global_position - get_global_mouse_position()
		
		# Does not have an effect if bigger than max radius
		if direction.length() > maxRadius:
			return
		
		var distance = clamp(direction.length(), minRadius, maxRadius)
		
		# if close to max, close to 0, if close to min, close to power
		# ease to make the force logarithmic instead of lin
		var boostStrength = remap(distance, minRadius, maxRadius, 1, 0)
		var boost = direction.normalized() * power * boostStrength
		apply_central_force(boost)

func _draw() -> void:
	return #comment to get gizmos
	draw_circle(get_global_mouse_position(), maxRadius, Color.DARK_BLUE)
	draw_circle(get_global_mouse_position(), minRadius, Color.AQUA)


func _on_body_entered(body: Node) -> void:
	#How to detect walls?
	print("Collided with " + body.name)
	oxygen -= oxygenLossPerImpact
	processOxygen(0)
