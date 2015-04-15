extends Node2D

var application

var level

var messages

var current_dialog_index = 0

var current_dialog

func _init(application, level, messages):
	self.application = application
	self.level = level
	self.messages = messages
	
func start():
	show_dialogs()

func show_dialogs():
	if current_dialog_index >= messages.size():
		level.start()
		return
		
	var dialog_scene = preload("res://scenes/ui/pre_level_dialog.xml")
	current_dialog = dialog_scene.instance()
	current_dialog.get_node("label").set_text(messages[current_dialog_index])
	var button = current_dialog.get_node("button")
	button.set_text(get_button_text())
	button.connect("pressed", self, "on_button_clicked")
	
	level.get_node("ui_layer").add_child(current_dialog)
	center()

func get_button_text():
	if current_dialog_index == messages.size() - 1:
		return "Start"
	else:
		return "Next"

func on_button_clicked():
	current_dialog_index = current_dialog_index + 1
	current_dialog.queue_free()
	show_dialogs()

func center():
	var pos = current_dialog.get_pos()
	pos.x = (application.get_width() - current_dialog.get_size().width) / 2
	pos.y = (application.get_height() - current_dialog.get_size().height) / 2
	current_dialog.set_pos(pos)
