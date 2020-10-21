extends StaticBody

const ANIMATION_NAME = "DoorOpening"

onready var anim_open: AnimationPlayer = get_parent().get_node("AnimationPlayer")

func open_door_bullet() -> void:
	anim_open.play(ANIMATION_NAME)
	visible = false
	collision_layer = 0
	collision_mask = 0
