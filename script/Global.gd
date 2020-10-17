extends Node
# See: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html#custom-scene-switcher

func goto_scene(path: String):
	call_deferred("_deferred_goto_scene", path)

func goto_scene_from_resource(scene_resource: Resource):
	# It is now safe to remove the current scene
	var new_scene = scene_resource.instance()
	get_tree().current_scene.free()
	get_tree().current_scene = null
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func _deferred_goto_scene(path: String):
	goto_scene_from_resource(ResourceLoader.load(path))
