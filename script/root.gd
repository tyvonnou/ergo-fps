extends Spatial

func _process(delta):
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$Control.show()
