
onready var dialog_label: Label = $MarginContainer/Panel/VBoxContainer/DialogLabel
onready var timer: Timer = $Timer

func update_text(length: int) -> void:
	dialog_label.visible_characters += length
	if dialog_label.visible_characters < dialog_label.get_total_character_count():
		timer.start()

func _ready() -> void:
	update_text(1)

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		if dialog_label.visible_characters >= dialog_label.get_total_character_count():
			print("Next dialog")
		else:
			timer.stop()
			call_deferred("update_text", dialog_label.get_total_character_count() - dialog_label.visible_characters)
		Input.action_release("ui_accept")

func _on_Timer_timeout() -> void:
	update_text(1)
