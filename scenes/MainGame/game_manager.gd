extends Node2D
class_name GameManager

var playerTimer:float = 0

var latestCheckpoint:Checkpoint = null
var collectedPowerups = []

const powerupOffset := Vector2(100000,100000)
var just_died := true #first checkpoing should not display audio

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
	$Player.reset(latestCheckpoint.global_position)
	resetPowerups()
	just_died = true

func resetPowerups() -> void:
	for powerup in collectedPowerups:
		powerup.position -= powerupOffset
	collectedPowerups.clear()

func _process(delta: float) -> void:
	playerTimer += delta

func _on_checkpoint_player_entered_checkpoint(checkpoint: Checkpoint) -> void:
	latestCheckpoint = checkpoint
	if !just_died:
		$HealingAudioPlayer.play()
	just_died = false

func _on_powerup_collected(powerup: Invincibility) -> void:
	collectedPowerups.append(powerup)
	powerup.position += powerupOffset
	$PowerupAudioPlayer.play()

func _on_player_win() -> void:
	PlayerData.time = playerTimer
	get_tree().change_scene_to_file.bind("res://scenes/VictoryScreen/VictoryScreen.tscn").call_deferred()
