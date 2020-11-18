extends "res://scene/AreaBullet/AreaBullet.gd"

func _init() -> void:
	damage = 1
	speed = -30.0
	signal_name = "bullet_hit"
	audio_stream.append(preload("res://sound/piou/piou.ogg"))
	audio_stream.append(preload("res://sound/piou/piou1.ogg"))
