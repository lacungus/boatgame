extends Node2D

var characters

var character_positions

var index

var application

var is_game_running = true

var level_manager

var last_result

var level_started_timestamp = null

var seconds_total = 0

func init(application, index, characters, character_positions):
	self.application = application
	self.characters = characters
	self.character_positions = character_positions
	self.index = index
	
	level_manager = application.get_level_manager()
	
func _ready():	
	start()

func _fixed_process(delta):
	if is_game_running:
		run(delta)

func run(delta):
	update_timer()
	
	if is_lost():
		application.on_level_lost()
		return	
	if is_won():
		application.on_level_won()
		return

func update_timer():
	var current_timestamp = OS.get_ticks_msec()
	var time_passed = current_timestamp - level_started_timestamp
	
	var text = str(time_passed / 1000) + ":" + str((time_passed % 1000) / 10)
	
	get_node("timer_label").set_text(text)
	pass

func is_lost():
	for character in characters:
		if character.get_is_player() && character.is_dead():
			return true
	return false
	
func is_won():
	for character in characters:
		if !character.get_is_player() && !character.is_dead():
			return false
	return true
	
func start():
	is_game_running = true

	get_node("current_level_label").set_text("Level " + str(index))
	
	for character in characters:
		add_child(character)

	for character1 in characters:
		for character2 in characters:
			PS2D.body_add_collision_exception(character1.get_rid(), character2.get_rid())
			
	var i = 0
	while i < characters.size():
		var character = characters[i]
		var pos = character_positions[i]
		character.set_pos(pos)
		i = i + 1
	
	level_started_timestamp = OS.get_ticks_msec()

	set_fixed_process(true)

func cleanup():
	for character in characters:
		remove_child(character)
		
	get_node("/root/Game/boat/top").set_rot(0)
	
	get_node("status_label").set_text("")
	
func _on_Timer_timeout():
	
	seconds_total = seconds_total + 1
	get_node("total_time").set_text("It's been " + str(seconds_total) + " seconds since the start of the game.")

func get_characters():
	return characters
