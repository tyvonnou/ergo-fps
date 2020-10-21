extends Spatial

func _process(delta):
	if Input.is_action_pressed("pause"):
		if $Camera/AnimationPlayer.is_active():
			$Camera/AnimationPlayer.seek($Camera/AnimationPlayer.get_animation("Cine").get_length())
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.action_release("pause")
		$Control.show()
