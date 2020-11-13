extends Spatial

var checkpoint: Vector3
onready var player = $Player

func _ready():
	checkpoint = Vector3(player.transform.origin)
	checkpoint.y += 10.0

func _process(delta: float) -> void:
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Input.action_release("pause")
		$Control.show()

func _on_Player_falling():
	player.falling_gravity_minus = 10.0
	player.transform.origin = checkpoint
	player.set_deferred("falling_gravity_minus", 0.0)
