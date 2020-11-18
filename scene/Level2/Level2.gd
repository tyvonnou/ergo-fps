extends Spatial

func _ready() -> void:
	Global.emit_signal("play_mode")
	$CutSceneCamera.current = false

func _on_Door_rocket_hit(node: StaticBody) -> void:
	$CutSceneCamera/CutScenePlayer.play("DoorOpening")

func _on_Door_bullet_hit(node: StaticBody) -> void:
	print(node)
