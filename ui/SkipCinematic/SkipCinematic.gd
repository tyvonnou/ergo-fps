extends Control

signal complete

var skipping: bool setget set_skipping, is_skipping

var co: GDScriptFunctionState

onready var skip_cine: ProgressBar = $MarginContainer/VBoxContainer/ProgressBar

func set_skipping(value: bool) -> void:
	skip_cine.visible = value
	
func is_skipping() -> bool:
	return skip_cine.visible

func _ready():
	co = _skipping()

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		self.skipping = true
	if Input.is_action_just_released("pause"):
		self.skipping = false

func _on_ProgressBar_value_changed(value: float) -> void:
	print("%f/%f" % [value, skip_cine.max_value])
	if value >= skip_cine.max_value:
		print("emit complete")
		emit_signal("complete")

func _skipping():
	while skip_cine.value < skip_cine.max_value:
		yield(get_tree(), "idle_frame")
		skip_cine.value = 0
		while self.skipping:
			yield(get_tree().create_timer(skip_cine.step), "timeout")
			skip_cine.value += skip_cine.step
