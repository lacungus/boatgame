extends Node2D

var application
var is_game_running = true

var level_manager
var current_level

var last_result

var level_started_timestamp = null

func _ready():	
	application = get_node("/root/application")

	var level_manager_class = preload("res://level_manager.gd")
	level_manager = level_manager_class.new(application)
	application.set_level_manager(level_manager)
	
	current_level = level_manager.get_next_level()
	start_level()
	
	set_process(true)

func _process(delta):
	if is_game_running:
		run(delta)
	else:
		if Input.is_action_pressed("ui_accept"):
			if last_result == "won":
				cleanup_level()
				current_level = level_manager.get_next_level()
				if current_level == null:
					get_node("status_label").set_text("No more levels!")
				else:
					start_level()
			else:
				cleanup_level()
				start_level()

func run(delta):
	update_timer()
	
	if is_lost():
		is_game_running = false
		get_node("status_label").set_text("You lost! \n Press Space or Enter \n to restart.")		
		last_result = "lost"	
		return	
	if is_won():
		is_game_running = false
		#get_node("status_sprite").show()
		get_node("status_label").set_text("You won! \n Press Space or Enter \n to start next level.")
		last_result = "won"
		return

func update_timer():
	var current_timestamp = OS.get_ticks_msec()
	var time_passed = current_timestamp - level_started_timestamp
	
	var text = str(time_passed / 1000) + ":" + str((time_passed % 1000) / 10)
	
	get_node("timer_label").set_text(text)
	pass

func is_lost():
	for character in current_level.characters:
		if character.get_is_player() && character.is_dead():
			return true
	return false
	
func is_won():
	for character in current_level.characters:
		if !character.get_is_player() && !character.is_dead():
			return false
	return true
	
func start_level():
	is_game_running = true

	get_node("current_level_label").set_text("Level " + str(current_level.get_index()))
	
	for character in current_level.characters:
		add_child(character)

	for character1 in current_level.characters:
		for character2 in current_level.characters:
			PS2D.body_add_collision_exception(character1.get_rid(), character2.get_rid())
			
	var i = 0
	while i < current_level.characters.size():
		var character = current_level.characters[i]
		var pos = current_level.character_positions[i]
		character.set_pos(pos)
		i = i + 1
	
	level_started_timestamp = OS.get_ticks_msec()
	
	application.set_current_level(current_level)

func cleanup_level():
	for character in current_level.characters:
		remove_child(character)
		
	get_node("/root/Game/boat/top").set_rot(0)
	
	get_node("status_label").set_text("")
	#get_node("status_sprite").hide()
	