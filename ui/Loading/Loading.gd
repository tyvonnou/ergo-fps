extends Control
# See: https://docs.godotengine.org/fr/stable/tutorials/io/background_loading.html

const LOADING_TEXT = "Loading"
const LOADING_CHAR = "."

var thread: Thread
var loading_max_len = LOADING_TEXT.length() + 3
onready var progress_bar = $MarginContainer/VBoxContainer/ProgressBar
onready var label_loading = $MarginContainer/VBoxContainer/LabelLoading

func load_scene(path: String):
	if Global.ON_NAVIGATOR:
		call_deferred("_thread_load", path)
	else:
		thread = Thread.new()
		thread.start(self, "_thread_load", path)
	show()

func _async_load(path: String):
	var ril = ResourceLoader.load_interactive(path)
	progress_bar.call_deferred("set_max", ril.get_stage_count())
	var res: Resource
	while true:
		var err = ril.poll()
		progress_bar.call_deferred("set_value", ril.get_stage())
		if err == ERR_FILE_EOF:
			res = ril.get_resource()
			break
		elif err != OK:
			print("There was an error loading\n", err)
			break
		yield(get_tree(), "idle_frame")
	return res

func _thread_load(path: String):
	var co = _async_load(path)
	_thread_done(yield(co, "completed"))

func _thread_done(resource: Resource):
	assert(resource)
	# Required to wait threads
	if thread:
		thread.wait_to_finish()
	Global.scene_from_resource(resource)

func _on_Timer_timeout():
	var text = label_loading.get_text()
	if text.length() >= loading_max_len:
		text = LOADING_TEXT
	else:
		text += LOADING_CHAR
	label_loading.set_text(text)
