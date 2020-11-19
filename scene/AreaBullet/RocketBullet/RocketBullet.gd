extends "res://scene/AreaBullet/AreaBullet.gd"

func random_audio() -> AudioStream:
	return audio_stream[0]

func _init():
	damage = 5
	damage = 10
	speed = -30.0
	signal_name = "rocket_hit"
	audio_stream.append(preload("res://sound/piou/rocket-launcher.ogg"))
