extends Node2D

var application

var characters

var character_positions

var index

var seconds_total = 0

# To get X stars, a player has to complete the level in seconds_for_stars[X - 1] seconds of faster
var seconds_for_stars

var stars = null

var wind = null

var pre_level

var time_tracker

# PUBLIC
func init(application, index, characters, character_positions, seconds_for_stars, wind, pre_level_messages):
	self.application = application
	self.characters = characters
	self.character_positions = character_positions
	self.index = index
	self.seconds_for_stars = seconds_for_stars
	self.wind = wind
	self.pre_level = preload("res://src/pre_level.gd").new(application, self, pre_level_messages)
	self.time_tracker = preload("res://src/time_tracker.gd").new(application)
	
func _fixed_process(delta):
	if is_lost():
		application.on_level_lost()
		return
	if is_won():
		calculate_stars()
		application.on_level_won()
		return

func _ready():
	pre_level.start()

func get_player():
	for character in characters:
		if character.get_is_player():
			return character
	return null

func get_stars():
	return stars
	
func get_index():
	return index
	
func get_time_tracker():
	return time_tracker

func on_pause():
	time_tracker.on_pause()

func on_resume():
	time_tracker.on_resume()

# PRIVATE

func calculate_stars():
	var time_elapsed = time_tracker.get_time_elapsed()
	if time_elapsed <= seconds_for_stars[2] * 1000:
		stars = 3
		return
	if time_elapsed <= seconds_for_stars[1] * 1000:
		stars = 2
		return
	if time_elapsed <= seconds_for_stars[0] * 1000:
		stars = 1
		return
	stars = 0
	
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
	# The game can be paused at this moment.
	# Resume.
	application.get_tree().set_pause(false)

	set_level_label()
	add_characters()
	add_collision_exceptions()
	add_wind()
	add_time_tracker()
	
	set_fixed_process(true)

func set_level_label():
	get_node("ui_layer/current_level_label").set_text("Level " + str(index))
	
func add_characters():
	for character in characters:
		get_node("main_layer").add_child(character)
	var i = 0
	while i < characters.size():
		var character = characters[i]
		var pos = character_positions[i]
		character.set_pos(pos)
		i = i + 1

func add_wind():
	get_node("main_layer").add_child(wind)

func add_time_tracker():
	get_node("main_layer").add_child(time_tracker)

# Add collision exceptions for each pair of characters
func add_collision_exceptions():
	for character1 in characters:
		for character2 in characters:
			PS2D.body_add_collision_exception(character1.get_rid(), character2.get_rid())

func get_characters():
	return characters
