extends Area

var speed : float = -30.0
var damage : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# called every frame
func _process (delta):
	# move the bullet forwards
	translation += global_transform.basis.z * speed * delta

func _on_AreaBullet_body_entered(body):
	# does this body have a 'take_damage' function?
	# if so, deal damage and destroy the bullet
	if body.has_method("open_door_bullet"):
		body.open_door_bullet()
		destroy()

# destroys the bullet
func destroy():
	queue_free()

func _on_Timer_timeout():
	destroy()
