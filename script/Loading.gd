extends Control
# See: https://docs.godotengine.org/fr/stable/tutorials/io/background_loading.html

const TIME_MAX = 100 # msec
const SIMULATED_DELAY_SEC = 0.1

var thread: Thread
onready var progress_bar = $MarginContainer/VBoxContainer/ProgressBar

func load_scene(path: String):
	thread = Thread.new()
	thread.start(self, "_thread_load", path)
	show()

func _thread_load(path: String):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	# Call deferred to configure max load steps
	progress_bar.call_deferred("set_max", ril.get_stage_count())
	
	var res: Resource
	while true: # Iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread
		progress_bar.call_deferred("set_value", ril.get_stage())

		# Simulate a delay
		OS.delay_msec(int(SIMULATED_DELAY_SEC * 1000.0))

		# Load step
		var err = ril.poll()
		if err == ERR_FILE_EOF: # Loading done
			res = ril.get_resource()
			break
		elif err != OK: # Error
			print("There was an error loading")
			print(err)
			break
	call_deferred("_thread_done", res)

func _thread_done(resource: Resource):
	assert(resource)
	# Required to wait threads
	thread.wait_to_finish()
	hide()
	Global.goto_scene_from_resource(resource)
