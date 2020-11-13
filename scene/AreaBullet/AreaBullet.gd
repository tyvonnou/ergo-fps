extends Area

var streams = []
var speed: float = -30.0
var damage: int = 1

# called every frame
func _process(delta: float) -> void:
	# move the bullet forwards
	translation += global_transform.basis.z * speed * delta

func _on_AreaBullet_body_entered(body: Node) -> void:
	body.emit_signal("bullet_hit", body)
	queue_free()

func _on_Timer_timeout() -> void:
	queue_free()
