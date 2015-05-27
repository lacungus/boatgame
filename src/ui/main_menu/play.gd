extends Control

func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		var application = get_node("/root/application")
		var level_manager = application.get_level_manager()
		if level_manager.get_current_level_id() <= level_manager.get_level_count():
			# Game not finished yet.
			application.get_scene_manager().goto_level(level_manager.get_current_level_id())
		else:
			# Game finished: show Levels menu
			application.get_scene_manager().goto_levels_menu()
