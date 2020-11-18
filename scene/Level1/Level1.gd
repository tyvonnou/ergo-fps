extends Spatial

var checkpoint: Vector3
onready var player := $Player
onready var cut_scene: CutScene = $CutScene

func _ready() -> void:
	cut_scene.add("CutScene1", preload("res://scene/Level1/CutScene1.anim"))
	cut_scene.add("DoorOpening", preload("res://scene/Level1/DoorOpening.anim"))
	cut_scene.play("CutScene1")
	checkpoint = Vector3(player.transform.origin)
	checkpoint.y += 10.0
	Global.connect("skip", self, "skip_cut_scene")

func _on_Player_falling() -> void:
	player.falling_gravity_minus = 10.0
	player.transform.origin = checkpoint
	player.set_deferred("falling_gravity_minus", 0.0)

func _on_Door_bullet_hit(node: StaticBody) -> void:
	node.visible = false
	node.collision_layer = 0
	node.collision_mask = 0
	cut_scene.play("DoorOpening")

func _on_LevelEnd_body_entered(body):
	$LoadingControl.load_scene("res://scene/Level2/Level2.tscn")
