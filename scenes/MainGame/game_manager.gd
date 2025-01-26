extends Node2D
class_name GameManager

var playerTimer:float = 0

var latestCheckpoint:Checkpoint = null
var collectedPowerups = []

func _ready() -> void:
	playerTimer = 0
	for child in get_children():
		if child is Checkpoint:
			(child as Checkpoint).player_entered_checkpoint.connect(_on_checkpoint_player_entered_checkpoint)
		if child is Invincibility:
			(child as Invincibility).powerup_collected.connect(_on_powerup_collected)
		if child is FinalTarget:
			(child as FinalTarget).player_reached_target.connect(_on_player_win)

func _on_player_player_died() -> void:
	($Player as Player).gainOxygen(100)
	$Player.reset(latestCheckpoint.global_position)
	for powerup in collectedPowerups:
		powerup.show()
		powerup.set_physics_process(true)

func _process(delta: float) -> void:
	playerTimer += delta

func _on_checkpoint_player_entered_checkpoint(checkpoint: Checkpoint) -> void:
	latestCheckpoint = checkpoint

func _on_powerup_collected(powerup: Invincibility) -> void:
	collectedPowerups.append(powerup)
	powerup.hide()
	powerup.set_physics_process(false)

func _on_player_win() -> void:
	PlayerData.time = playerTimer
	get_tree().change_scene_to_file("res://scenes/VictoryScreen/VictoryScreen.tscn")
