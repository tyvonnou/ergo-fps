extends "res://ui/Menu/MenuAbstract.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_ButtonNewGame_pressed():
	$LoadingControl.load_scene("res://scene/Level1/Level1.tscn")
