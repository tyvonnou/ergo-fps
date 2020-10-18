extends StaticBody

const ANIMATION_NAME = "AnimOpen"

var anim_open: AnimationPlayer
var timer: Timer

func _ready():
	anim_open = get_parent().get_node("AnimationPlayer")
	timer = get_parent().get_node("Timer")

func open_door_bullet():
	anim_open.play(ANIMATION_NAME)
	timer.start()

func _on_Timer_timeout():
	anim_open.play_backwards(ANIMATION_NAME)
	timer.stop()
