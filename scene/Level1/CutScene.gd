extends Node

onready var timer: Timer = $CameraCinematic/Timer
onready var anim_player = $CameraCinematic/AnimationPlayer

func _ready():
	anim_player.play("Cine")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		timer.call_deferred("start")
	elif Input.is_action_just_released("pause"):
		timer.call_deferred("stop")

func _on_Timer_timeout():
	timer.disconnect("timeout", self, "_on_Timer_timeout")
	anim_player.advance(anim_player.get_current_animation_length())
	Input.action_release("pause")
