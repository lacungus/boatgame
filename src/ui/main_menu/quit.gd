extends Control

func _input_event(ev):
	if (ev.type==InputEvent.MOUSE_BUTTON and ev.pressed):
		OS.get_main_loop().quit()
