extends Spatial

var checkpoint: Vector3
var player: KinematicBody

func _on_Player_falling() -> void:
	player.falling_gravity_minus = 10.0
	player.transform.origin = checkpoint
	player.set_deferred("falling_gravity_minus", 0.0)

func _on_CutScenePlayer_animation_started(anim_name: String) -> void:
	player.playing_mode(false)

func _on_CutScenePlayer_animation_finished(anim_name: String) -> void:
	player = $Player
	player.playing_mode(true)
	checkpoint = Vector3(player.transform.origin)
	checkpoint.y += 10.0

func _on_Door_bullet_hit(node: StaticBody) -> void:
	node.visible = false
	node.collision_layer = 0
	node.collision_mask = 0
	$CutSceneCamera/CutScenePlayer.play("DoorOpening")
