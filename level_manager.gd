var count = 0

var application

var current_level

func _init(application):
	self.application = application
	
func get_current_level():
	return current_level
	
func get_next_level():
	count = count + 1
	if count == 1:
		var characters = [application.create_player(), application.create_following_opponent()]
		var positions = [Vector2(100, 100), Vector2(400, 300)]
		return create_level(characters, positions)

	if count == 2:
		var characters = [application.create_player(), application.create_swinging_opponent(), application.create_swinging_opponent()]
		var positions = [Vector2(100, 100), Vector2(300, 300), Vector2(400, 300)]
		return create_level(characters, positions)
	
	return null;

func create_level(characters, positions):
	var scene_class = ResourceLoader.load("res://scenes/level.xml")
	var scene_instance = scene_class.instance()
	scene_instance.init(application, count, characters, positions)
	current_level = scene_instance
	return scene_instance
