extends Control

func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		var application = get_node("/root/application")
		application.get_tree().set_pause(true)
		application.get_level_manager().get_current_level().on_pause()
		application.get_node("/root/Game/ui_layer/in_level_menu").show()
