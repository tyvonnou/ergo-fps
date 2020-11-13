extends "res://ui/Menu/MenuAbstract.gd"

func _on_ButtonContinue_pressed():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_on_ButtonContinue_pressed()
		Input.action_release("pause")
