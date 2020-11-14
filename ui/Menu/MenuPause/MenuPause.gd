extends "res://ui/Menu/MenuAbstract.gd"

func resume() -> void:
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false

func pause() -> void:
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	show()

func _ready() -> void:
	var skip_cut_scene := $MarginContainer/VBoxContainer/VBoxContainer/ButtonSkipCutScene
	Global.connect("cinematic_mode", skip_cut_scene, "show")
	Global.connect("play_mode", skip_cut_scene, "hide")

func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("pause"):
		get_tree().set_input_as_handled()
		if get_tree().paused:
			resume()
		else:
			pause()

func _on_ButtonMenu_pressed() -> void:
	Global.goto_scene("res://ui/Menu/MenuTitle/MenuTitle.tscn")

func _on_ButtonSkipCutScene_pressed() -> void:
	Global.emit_signal("skip")
	resume()
