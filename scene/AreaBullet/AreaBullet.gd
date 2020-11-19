extends Area
class_name AreaBullet

var audio_stream := []
var speed: float
var damage: int
var signal_name: String

func random_audio() -> AudioStream:
	return Global.rand_pick(audio_stream)

func _process(delta: float) -> void:
	# move the bullet forwards
	translation += global_transform.basis.z * speed * delta

func _on_AreaBullet_body_entered(body: Node) -> void:
	body.emit_signal(signal_name, body)
	body.emit_signal("hit", damage)
	print(body)
	queue_free()

func _on_Timer_timeout() -> void:
	queue_free()
