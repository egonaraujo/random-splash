extends RigidBody2D

class_name Player

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

var invincibilityTimer:float = 0
var bubbleRotationAnimation:float = 0.12

func IsInvincible() -> bool: return invincibilityTimer > 0

#Signals
signal player_died()

func _ready() -> void:
	contact_monitor = true
	max_contacts_reported = 1

func _physics_process(delta: float) -> void:
	processPowerups(delta)
	processOxygen(delta)
	processInput()
	$Sprite.rotate(bubbleRotationAnimation*delta)
	$Capivara.rotate(bubbleRotationAnimation*delta * -1)
	if ($Sprite.rotation > 0.11 or $Sprite.rotation < -0.11):
		bubbleRotationAnimation *= -1 #change rotation
		

func processPowerups(delta: float) -> void:
	if IsInvincible():
		invincibilityTimer -= delta
		if !IsInvincible():
			$Sprite.self_modulate = Color(1.0,1.0,1.0,1.0)

func processOxygen(delta:float) -> void:
	if IsInvincible():
		return
	oxygen -= oxygenLossPerSec * delta
	if oxygen <= 0:
		player_died.emit()
		return
	var oxygenScale = remap(oxygen, 0, 100, 0.4, 1)
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

func _on_body_entered(body: Node) -> void:
	var physicsBody:PhysicsBody2D = body

	match physicsBody.collision_layer:
		Enums.CollisionLayers.Walls:
			if IsInvincible():
				return
			oxygen -= oxygenLossPerImpact

		Enums.CollisionLayers.Killer:
			if IsInvincible():
				return
			oxygen = 0
	processOxygen(0)

func gainOxygen(amount: float) -> void:
	oxygen = clamp(oxygen + amount,-10, 100)	
	processOxygen(0)

func grantInvincibility(time: float) -> void:
	invincibilityTimer = time
	$Sprite.self_modulate = Color(0.36,0.36,0.36,1.0)
