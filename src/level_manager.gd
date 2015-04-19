var count = 1

var application

var current_level

var middle_x
var start_y

var stars_per_level 

const BASE_OFFSET = 10

# PUBLIC
func _init(application):
	self.application = application
	middle_x = application.get_width() / 2
	start_y = 350
	
	stars_per_level = []
	for i in range(get_level_count() + 1):
		stars_per_level.append(null)
	
func get_current_level():
	return current_level
	
func get_next_level():
	count = count + 1
	return get_level(count)

func clone_current_level():
	return get_level(count)

func set_stars_per_level(level, stars):
	stars_per_level[level] = stars

func get_stars_per_level(level):
	return stars_per_level[level]
	
func set_count(count):
	self.count = count
	
func get_current_index():
	return count

# PRIVATE

# https://docs.google.com/spreadsheets/d/11gLwcFh-6PSZE6FDh4btUVg8kmBojMQN6e537Xg2fT0/edit#gid=0
# TODO maybe keep this all in a config file?
# TODO write a function for determining character positions
func get_level(index, set_current = false):
	if set_current:
		count = index
		
	var character_factory = application.get_character_factory() 
	var wind = preload("res://src/wind.gd").new(application, 0.001, 0.0001)
	
	if index == 1:
		# No wind
		# One Chaotic Opponent
		var characters = [character_factory.create_chaotic_opponent(), character_factory.create_player()]
		var positions = start_positions(characters)
		wind = preload("res://src/wind.gd").new(application, 0, 1)
		var seconds_for_stars = [120, 60, 30]
		var pre_level_messages = ["Look out! There is a ghost on your boat! You have to get rid of it!", "Push the buttons in the bottom to control your character. You goal is to force the enemy to fall off the board."]
		return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

	if index == 2:
		# No wind
		# Two Chaotic Opponents
		var characters = [character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_player()]
		var positions = start_positions(characters)
		wind = preload("res://src/wind.gd").new(application, 0, 1)
		var seconds_for_stars = [120, 60, 30]
		var pre_level_messages = ["Oh no! Two more ghosts are here! Quick, get rid of them!"]
		return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

	if index == 3:
		# Weak wind
		# Four ghosts
		var characters = [character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_player()]
		var positions = start_positions(characters)
		wind = preload("res://src/wind.gd").new(application, 0.0001, 0.0001)
		var seconds_for_stars = [120, 60, 30]
		var pre_level_messages = ["Too many ghosts! Luckily, fresh breeze is coming. Try using it for fighting your enemies."]
		return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

	if index == 4:
		# Four ghosts,
		# Two zombies
		var characters = [character_factory.create_following_opponent(), character_factory.create_following_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_chaotic_opponent(), character_factory.create_player()]
		var positions = start_positions(characters)
		var seconds_for_stars = [100, 50, 25]
		var pre_level_messages = []
		return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

	if index == 5:
		var characters = [character_factory.create_opposing_opponent(), character_factory.create_player()]
		var positions = start_positions(characters)
		var seconds_for_stars = [100, 50, 25]
		var pre_level_messages = []
		return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)
	
	return null

func create_level(characters, positions, seconds_for_stars, wind, pre_level_messages):
	var scene_class = ResourceLoader.load("res://scenes/level.xml")
	var scene_instance = scene_class.instance()
	scene_instance.init(application, count, characters, positions, seconds_for_stars, wind, pre_level_messages)
	current_level = scene_instance
	return scene_instance

func start_positions(characters):
	var result = []
	for i in range(characters.size() - 1):
		# TODO: make sure it's always above the boat
		result = result + [character_position(i)]
	# Last one should always be the player
	result += [Vector2(middle_x, start_y)]
	return result

func character_position(index):
	var offset = (index + 1) * BASE_OFFSET
	if index % 2 == 0:
		return Vector2(middle_x + offset, start_y)
	else:
		return Vector2(middle_x - offset, start_y)

func get_level_count():
	return 5
