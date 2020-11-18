extends Node
# See: https://docs.godotengine.org/en/3.1/getting_started/step_by_step/singletons_autoload.html#custom-scene-switcher

signal cinematic_mode
signal play_mode
signal skip

var ON_NAVIGATOR := OS.has_feature("HTML5")

func goto_scene(path: String) -> void:
	call_deferred("_deferred_goto_scene", path)
	
func scene_from_resource(scene_resource: Resource) -> void:
	call_deferred("_deferred_scene_from_resource", scene_resource)

func rand_pick(array: Array):
	return array[randi() % len(array)]

func _init():
	pass

func _deferred_scene_from_resource(scene_resource: Resource) -> void:
	# It is now safe to remove the current scene
	var tree := get_tree()
	var new_scene: Node = scene_resource.instance()
	var current_scene: Node = tree.current_scene
	current_scene.free()
	tree.root.remove_child(current_scene)
	tree.current_scene = null
	tree.root.add_child(new_scene)
	tree.current_scene = new_scene

func _deferred_goto_scene(path: String):
	call_deferred("_deferred_scene_from_resource", load(path))
