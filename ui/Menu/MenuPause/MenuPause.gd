extends "res://ui/Menu/MenuAbstract.gd"

func resume():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func pause():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	show()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		resume()

func _on_ButtonContinue_pressed():
	resume()
