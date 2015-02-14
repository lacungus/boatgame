extends Node2D

var application

var characters

var character_positions

var index

var level_started_timestamp = null

var seconds_total = 0

# PUBLIC
func init(application, index, characters, character_positions):
	self.application = application
	self.characters = characters
	self.character_positions = character_positions
	self.index = index
	
func _fixed_process(delta):
	update_timer()
	
	if is_lost():
		application.on_level_lost()
		return	
	if is_won():
		application.on_level_won()
		return

func _ready():
	start()

func get_player():
	for character in characters:
		if character.get_is_player():
			return character
	return null

# PRIVATE

func update_timer():
	var current_timestamp = OS.get_ticks_msec()
	var time_passed = current_timestamp - level_started_timestamp
	
	var text = str(time_passed / 1000) + ":" + str((time_passed % 1000) / 10)
	
	get_node("timer_label").set_text(text)
	pass

# Lost when the player is dead
func is_lost():
	if Input.is_action_pressed("lose"):
		return true
	return get_player().is_dead()
	
# Won when all non-players are dead
func is_won():
	if Input.is_action_pressed("win"):
		return true
	for character in characters:
		if !character.get_is_player() && !character.is_dead():
			return false
	return true

func start():
	set_level_label()
	add_characters()
	add_collision_exceptions()
	
	level_started_timestamp = OS.get_ticks_msec()
	set_fixed_process(true)

func set_level_label():
	get_node("current_level_label").set_text("Level " + str(index))
	
func add_characters():
	for character in characters:
		add_child(character)
	var i = 0
	while i < characters.size():
		var character = characters[i]
		var pos = character_positions[i]
		character.set_pos(pos)
		i = i + 1

# Add collision exceptions for each pair of characters
func add_collision_exceptions():
	for character1 in characters:
		for character2 in characters:
			PS2D.body_add_collision_exception(character1.get_rid(), character2.get_rid())

func _on_Timer_timeout():
	seconds_total = seconds_total + 1
	get_node("total_time").set_text("It's been " + str(seconds_total) + " seconds since the start of the game.")

func get_characters():
	return characters
