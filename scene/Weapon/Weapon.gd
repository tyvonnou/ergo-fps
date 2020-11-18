extends Area
class_name Weapon

signal taken()

var weapon_name: String

onready var mesh := $MeshWeapon
onready var signal_name: String

func _process(delta: float) -> void:
	rotate_y(delta * 4)

func _on_Arm_body_entered(body: Node) -> void:
	body.emit_signal("new_weapon", self)

func _on_Weapon_taken():
	queue_free()
