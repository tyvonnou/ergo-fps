extends Control

func _on_ExitButton_pressed():
	get_tree().quit()
	if Constants.ON_NAVIGATOR:
		JavaScript.eval("alert('Bye!\\nYou can close this window')")
	else:
		print("Bye!")
