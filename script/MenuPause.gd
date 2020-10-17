extends "res://script/MenuAbstract.gd"

func _on_ButtonContinue_pressed():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
