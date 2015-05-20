extends Node2D

var application

var started_timestamp

# PUBLIC

func _init(application):
	self.application = application

func _ready():
	started_timestamp = OS.get_ticks_msec()
	set_fixed_process(true)

func _fixed_process(delta):
	update_label()

func get_time_elapsed():
	var current_timestamp = OS.get_ticks_msec()
	return current_timestamp - started_timestamp

# PRIVATE

func update_label():
	var time_elapsed = get_time_elapsed()
	
	var text = str(time_elapsed / 1000) + ":" + str((time_elapsed % 1000) / 10)
	get_node("/root/Game/ui_layer/timer_label").set_text(text)
