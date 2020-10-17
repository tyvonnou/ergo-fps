extends Control

func _on_ExitButton_pressed():
	get_tree().quit()
	if Constants.ON_NAVIGATOR:
		JavaScript.eval("window.close()")
	else:
		print("bye")
