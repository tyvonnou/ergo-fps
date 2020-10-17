extends Node
# See: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html#custom-scene-switcher

var current_scene: Node

func goto_scene(path: String):
	call_deferred("_deferred_goto_scene", path)

func goto_scene_from_resource(scene_resource: Resource):
	# It is now safe to remove the current scene
	current_scene.free()
	current_scene = scene_resource.instance()

	# Add it to the active scene, as child of root.
	get_tree().get_root().add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene() API.
	get_tree().set_current_scene(current_scene)
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)

func _deferred_goto_scene(path: String):
	goto_scene_from_resource(ResourceLoader.load(path))
