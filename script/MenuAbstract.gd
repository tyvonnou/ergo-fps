extends Control

func _on_ExitButton_pressed():
	get_tree().quit()
	if Constants.ON_NAVIGATOR:
		JavaScript.eval("alert('bye !\\nYou can close this window')")
	else:
		print("bye")
