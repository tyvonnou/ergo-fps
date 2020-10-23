extends Node
# See: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html#custom-scene-switcher

func goto_scene(path: String) -> void:
	call_deferred("_deferred_goto_scene", path)
	
func scene_from_resource(scene_resource: Resource) -> void:
	call_deferred("_deferred_scene_from_resource", scene_resource)

func rand_pick(array: Array):
	return array[randi() % len(array)]

func _deferred_scene_from_resource(scene_resource: Resource) -> void:
	# It is now safe to remove the current scene
	var new_scene = scene_resource.instance()
	get_tree().current_scene.free()
	get_tree().current_scene = null
	get_tree().root.add_child(new_scene)
	get_tree().current_scene = new_scene

func _deferred_goto_scene(path: String):
	call_deferred("_deferred_scene_from_resource", ResourceLoader.load(path))
