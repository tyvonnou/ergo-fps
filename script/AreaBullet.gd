extends Area

var streams = []
var speed: float = -30.0
var damage: int = 1

# called every frame
func _process(delta):
	# move the bullet forwards
	translation += global_transform.basis.z * speed * delta

func _on_AreaBullet_body_entered(body):
	# does this body have a 'take_damage' function?
	# if so, deal damage and destroy the bullet
	print(body)
	if body.has_method("open_door_bullet"):
		body.open_door_bullet()
	queue_free()

func _on_Timer_timeout():
	queue_free()