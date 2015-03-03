var count = 0

var application

var current_level

var middle_x
var start_y

# PUBLIC
func _init(application):
	self.application = application
	middle_x = application.get_width() / 2
	start_y = 350
	
func get_current_level():
	return current_level
	
func get_next_level():
	count = count + 1
	return get_level(count)

func clone_current_level():
	return get_level(count)

# PRIVATE

# TODO maybe keep this all in a config file?
func get_level(index):
	var character_factory = application.get_character_factory() 
	var wind = preload("res://src/wind.gd").new(0.001, 0.0001)
	
	if index == 1:
		var characters = [character_factory.create_sticking_opponent(), character_factory.create_player()]
		var positions = [Vector2(middle_x, start_y), Vector2(middle_x, start_y)]
		var seconds_for_stars = [100, 50, 25]
		return create_level(characters, positions, seconds_for_stars, wind)

	if index == 2:
		var characters = [character_factory.create_balancing_opponent(), character_factory.create_player()]
		var positions = [Vector2(middle_x, start_y), Vector2(middle_x + 50, start_y)]
		var seconds_for_stars = [100, 50, 25]
		return create_level(characters, positions, seconds_for_stars, wind)

	if index == 3:
		var characters = [character_factory.create_swinging_opponent(), character_factory.create_swinging_opponent(), character_factory.create_player()]
		var positions = [Vector2(middle_x, start_y), Vector2(middle_x + 50, start_y), Vector2(middle_x + 100, start_y)]
		var seconds_for_stars = [100, 50, 25]
		return create_level(characters, positions, seconds_for_stars, wind)

	if index == 4:
		var characters = [character_factory.create_following_opponent(), character_factory.create_following_opponent(), character_factory.create_following_opponent(), character_factory.create_player()]
		var positions = [Vector2(middle_x, start_y), Vector2(middle_x - 50, start_y), Vector2(middle_x + 50, start_y), Vector2(middle_x + 100, start_y)]
		var seconds_for_stars = [100, 50, 25]
		return create_level(characters, positions, seconds_for_stars, wind)

	if index == 5:
		var characters = [character_factory.create_opposing_opponent(), character_factory.create_player()]
		var positions = [Vector2(middle_x, start_y), Vector2(middle_x - 50, start_y)]
		var seconds_for_stars = [100, 50, 25]
		return create_level(characters, positions, seconds_for_stars, wind)
	
	return null

func create_level(characters, positions, seconds_for_stars, wind):
	var scene_class = ResourceLoader.load("res://scenes/level.xml")
	var scene_instance = scene_class.instance()
	scene_instance.init(application, count, characters, positions, seconds_for_stars, wind)
	current_level = scene_instance
	return scene_instance
