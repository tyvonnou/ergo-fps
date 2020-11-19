extends Spatial

var enemies := []

func _ready() -> void:
	Global.emit_signal("play_mode")
	$CutSceneCamera.current = false
	enemies.append($Enemy2)
	enemies.append($Enemy3)
	enemies.append($Enemy4)

func _on_Door_rocket_hit(node: StaticBody) -> void:
	$CutSceneCamera/CutScenePlayer.play("DoorOpening")

func _on_Door_bullet_hit(node: StaticBody) -> void:
	print(node)

func _on_Weapon_taken() -> void:
	var anim_player: AnimationPlayer
	for enemy in enemies:
		anim_player = enemy.get_node("AnimationPlayer")
		anim_player.play("Moving")
		anim_player.seek(rand_range(0, anim_player.current_animation_length))
		enemy.visible = true
