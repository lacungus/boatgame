# Level manager.
# Responsible for creating levels
# and maintaining data about them.

var application

var current_level_id = 1
var current_level

var stars

var levels_config

const BASE_OFFSET = 10

# PUBLIC
func _init(application):
	self.application = application
	parse_config()
	init_stars()
	
func get_current_level():
	return current_level
	
func get_next_level():
	current_level_id = current_level_id + 1
	return get_level(current_level_id)

func clone_current_level():
	return get_level(current_level_id)

func set_stars(level_id, stars):
	self.stars[level_id] = stars

func get_stars(level_id):
	return self.stars[level_id]
	
func set_current_level_id(current_level_id):
	self.current_level_id = current_level_id
	
func get_current_level_id():
	return current_level_id

# https://docs.google.com/spreadsheets/d/11gLwcFh-6PSZE6FDh4btUVg8kmBojMQN6e537Xg2fT0/edit#gid=0
func get_level(id, set_current = false):
	if set_current:
		current_level_id = id
	if id > get_level_count():
		return null

	var level_config = levels_config["levels"][id - 1]
	var wind = preload("res://src/wind.gd").new(application, level_config["wind"]["amplitude"], level_config["wind"]["period"])
	var pre_level_messages = level_config["pre_level_messages"]
	var seconds_for_stars = level_config["seconds_for_stars"]

	var characters = get_characters(level_config)
	var positions = start_positions(characters)

	return create_level(characters, positions, seconds_for_stars, wind, pre_level_messages)

# PRIVATE

func parse_config():
	var file = File.new()
	file.open("res://config/levels.json", 1)
	levels_config = {}
	var status = levels_config.parse_json(file.get_as_text())
	if status != OK:
		print("Failed to parse levels config")
		OS.get_main_loop().quit()

func get_characters(level_config):
	var character_types = level_config["character_types"]
	var character_factory = application.get_character_factory()
	var characters = []
	for character_type in character_types:
		var count = level_config["character_types"][character_type]
		for i in range(count):
			characters = characters + [character_factory.create(character_type)]
	characters = characters + [character_factory.create("player")]
	return characters;
	
func create_level(characters, positions, seconds_for_stars, wind, pre_level_messages):
	var scene_class = ResourceLoader.load("res://scenes/level.xml")
	var scene_instance = scene_class.instance()
	scene_instance.init(application, current_level_id, characters, positions, seconds_for_stars, wind, pre_level_messages)
	current_level = scene_instance
	return scene_instance

func start_positions(characters):
	var result = []
	var middle_x = application.get_width() / 2
	var start_y = 350

	for i in range(characters.size() - 1):
		# TODO: make sure it's always above the boat
		result = result + [character_position(i, middle_x, start_y)]
	# Last one should always be the player
	result += [Vector2(middle_x, start_y)]
	return result

func character_position(index, middle_x, start_y):
	var offset = (index + 1) * BASE_OFFSET
	if index % 2 == 0:
		return Vector2(middle_x + offset, start_y)
	else:
		return Vector2(middle_x - offset, start_y)

func get_level_count():
	return levels_config["levels"].size()

func init_stars():
	stars = []
	for i in range(get_level_count() + 1):
		stars.append(null)
