extends MeshInstance

var hp := 5

onready var anim_player := $AnimationPlayer

func _ready():
	var body = $StaticBody
	body.add_user_signal("hit", ["damage"])
	body.connect("hit", self, "_on_StaticBody_hit")

func _on_StaticBody_hit(damage: int) -> void:
	hp -= damage
	var current_position = anim_player.current_animation_position
	anim_player.play("Hurting")
	yield(anim_player, "animation_finished")
	if hp > 0:
		anim_player.play("Moving")
		anim_player.seek(current_position)
	else:
		anim_player.play("Dying")
		yield(anim_player, "animation_finished")
		queue_free()
