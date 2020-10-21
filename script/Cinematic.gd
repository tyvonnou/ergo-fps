extends Node

onready var timer: Timer = $Camera/Timer
onready var anim_player = $Camera/AnimationPlayer

func _ready():
	anim_player.play("Cine")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		timer.call_deferred("start")
	elif Input.is_action_just_released("pause"):
		timer.call_deferred("stop")

func _on_Timer_timeout():
	anim_player.seek(anim_player.get_animation("Cine").get_length())
	Input.action_release("pause")
