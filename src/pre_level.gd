extends Node2D

var application

var level

var messages

var current_dialog_index = 0

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
		
	var dialog = AcceptDialog.new()

	level.get_node("ui_layer").add_child(dialog)
	dialog.set_size(Vector2(200, 100))
	dialog.set_title("")
	dialog.set_text(messages[current_dialog_index])
	dialog.get_ok().set_text("Next")
	dialog.get_ok().connect("pressed", self, "on_next_clicked")
	dialog.popup_centered()

func on_next_clicked():
	current_dialog_index = current_dialog_index + 1
	show_dialogs()
