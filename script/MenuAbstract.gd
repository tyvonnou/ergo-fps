extends Control

func _on_ExitButton_pressed():
	get_tree().quit()
	if Global.ON_NAVIGATOR:
		JavaScript.eval("alert('Bye!\\nYou can close this window')")
	else:
		print("Bye!")
