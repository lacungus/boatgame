extends Control

func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		var application = get_node("/root/application")
		application.get_scene_manager().goto_level(application.get_level_manager().get_current_index())
