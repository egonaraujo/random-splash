extends Node

var time: float = 0
var isMusicOn : bool=true :
	set(value):
		isMusicOn = value
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !value)
