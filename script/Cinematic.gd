extends Node

onready var anim_player: AnimationPlayer = $CameraCinematic/AnimationPlayer
onready var skip_cinematic := $CameraCinematic/SkipCinematic

func _ready() -> void:
	anim_player.play("Cine")

func _on_SkipCinematic_complete() -> void:
	Input.action_release("pause")
	skip_cinematic.visible = false
	anim_player.advance(anim_player.get_current_animation_length())
