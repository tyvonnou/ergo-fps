extends Node

onready var timer: Timer = $CutSceneCamera/Timer
onready var anim_player = $CutSceneCamera/CutScenePlayer

func _ready():
	$Player.playing_mode(false)
	anim_player.play("CutScene1")

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		timer.call_deferred("start")
	elif Input.is_action_just_released("pause"):
		timer.call_deferred("stop")

func _on_Timer_timeout():
	timer.disconnect("timeout", self, "_on_Timer_timeout")
	anim_player.advance(anim_player.get_current_animation_length())
	Input.action_release("pause")
