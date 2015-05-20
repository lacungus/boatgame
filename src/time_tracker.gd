extends Node2D

var application

var last_started_timestamp

var elapsed_before_last_pause

var paused

# PUBLIC

func _init(application):
	self.application = application
	self.elapsed_before_last_pause = 0
	self.paused = false

func _ready():
	last_started_timestamp = OS.get_ticks_msec()
	set_fixed_process(true)

func _fixed_process(delta):
	update_label()

func get_time_elapsed():
	var current_timestamp = OS.get_ticks_msec()
	var result = elapsed_before_last_pause
	if !paused:
		result += current_timestamp - last_started_timestamp
	return result

func on_pause():
	paused = true
	var current_timestamp = OS.get_ticks_msec()
	elapsed_before_last_pause = elapsed_before_last_pause + current_timestamp - last_started_timestamp

func on_resume():
	paused = false
	last_started_timestamp = OS.get_ticks_msec()

# PRIVATE

func update_label():
	var time_elapsed = get_time_elapsed()
	
	var text = str(time_elapsed / 1000) + ":" + str((time_elapsed % 1000) / 10)
	get_node("/root/Game/ui_layer/timer_label").set_text(text)
