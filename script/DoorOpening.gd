extends StaticBody

const ANIMATION_NAME = "DoorOpening"

var anim_open: AnimationPlayer


func _ready():
	anim_open = get_parent().get_node("AnimationPlayer")


func open_door_bullet():
	anim_open.play(ANIMATION_NAME)
	visible = false
	collision_layer = 0
	collision_mask = 0
