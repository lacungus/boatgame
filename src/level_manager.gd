var count = 1

var application

var current_level

var middle_x
var start_y

var stars_per_level 

var levels_config

const BASE_OFFSET = 10

# PUBLIC
func _init(application):
	parse_config()

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

func parse_config():
	var file = File.new()
	file.open("res://config/levels.json", 1)
	levels_config = {}
	var status = levels_config.parse_json(file.get_as_text())
	if status != OK:
		print("Failed to parse levels config")
		OS.get_main_loop().quit()

# https://docs.google.com/spreadsheets/d/11gLwcFh-6PSZE6FDh4btUVg8kmBojMQN6e537Xg2fT0/edit#gid=0
func get_level(index, set_current = false):
	if set_current:
		count = index
	if index > get_level_count():
		return null

	var level_config = levels_config["levels"][index - 1]
	var wind = preload("res://src/wind.gd").new(application, level_config["wind"]["amplitude"], level_config["wind"]["period"])
	var pre_level_messages = level_config["pre_level_messages"]
	var seconds_for_stars = level_config["seconds_for_stars"]

	var character_types = level_config["character_types"]
	var character_factory = application.get_character_factory()
	var characters = []
	for character_type in character_types:
		characters = characters + [character_factory.create(character_type)]
	var positions = start_positions(characters)
	
	return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

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
