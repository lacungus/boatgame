extends Node2D

var application

var characters

var character_positions

var index

var level_started_timestamp = null

var seconds_total = 0

# To get X stars, a player has to complete the level in seconds_for_stars[X - 1] seconds of faster
var seconds_for_stars

var stars = null

var wind = null

var pre_level

# PUBLIC
func init(application, index, characters, character_positions, seconds_for_stars, wind, pre_level_messages):
	self.application = application
	self.characters = characters
	self.character_positions = character_positions
	self.index = index
	self.seconds_for_stars = seconds_for_stars
	self.wind = wind
	self.pre_level = preload("res://src/pre_level.gd").new(application, self, pre_level_messages)
	
func _fixed_process(delta):
	update_timer()
	
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
	
# PRIVATE

func calculate_stars():
	var current_timestamp = OS.get_ticks_msec()
	var time_passed = current_timestamp - level_started_timestamp
	if time_passed <= seconds_for_stars[2] * 1000:
		stars = 3
		return
	if time_passed <= seconds_for_stars[1] * 1000:
		stars = 2
		return
	if time_passed <= seconds_for_stars[0] * 1000:
		stars = 1
		return
	stars = 0
	
func update_timer():
	var time_passed = get_time_passed()
	
	var text = str(time_passed / 1000) + ":" + str((time_passed % 1000) / 10)
	
	get_node("ui_layer/timer_label").set_text(text)
	pass

func get_time_passed():
	var current_timestamp = OS.get_ticks_msec()
	return current_timestamp - level_started_timestamp

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
	add_wind()
	
	level_started_timestamp = OS.get_ticks_msec()
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

# Add collision exceptions for each pair of characters
func add_collision_exceptions():
	for character1 in characters:
		for character2 in characters:
			PS2D.body_add_collision_exception(character1.get_rid(), character2.get_rid())

func get_characters():
	return characters
