extends Node2D
class_name GameManager

var timer:float = 0

var latestCheckpoint:Checkpoint = null
var collectedPowerups = []

func _ready() -> void:
	timer = 0
	for child in get_children():
		if child is Checkpoint:
			(child as Checkpoint).player_entered_checkpoint.connect(_on_checkpoint_player_entered_checkpoint)
		if child is Invincibility:
			print(" ffound child invincibility")
			(child as Invincibility).powerup_collected.connect(_on_powerup_collected)

func _on_player_player_died() -> void:
	($Player as Player).gainOxygen(100)
	$Player.reset(latestCheckpoint.global_position)
	for powerup in collectedPowerups:
		powerup.show()
		powerup.set_physics_process(true)


	#get_tree().change_scene_to_file.bind("res://scenes/MainMenu/MainMenu.tscn").call_deferred()

func _process(delta: float) -> void:
	timer += delta

func _on_checkpoint_player_entered_checkpoint(checkpoint: Checkpoint) -> void:
	latestCheckpoint = checkpoint

func _on_powerup_collected(powerup: Invincibility) -> void:
	collectedPowerups.append(powerup)
	powerup.hide()
	powerup.set_physics_process(false)
