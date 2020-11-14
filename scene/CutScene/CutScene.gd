tool
extends Camera
class_name CutScene

onready var anim_player := $CutScenePlayer

func _ready():
	Global.connect("skip", self, "skip")

func add(name: String, anim: Animation) -> void:
	anim_player.add_animation(name, anim)

func play(name: String) -> void:
	anim_player.play(name)

func skip() -> void:
	anim_player.seek(anim_player.current_animation_length - 1e-6)

func _on_CutScenePlayer_animation_started(anim_name: String) -> void:
	Global.emit_signal("cinematic_mode")

func _on_CutScenePlayer_animation_finished(anim_name: String) -> void:
	Global.emit_signal("play_mode")
